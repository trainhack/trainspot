require 'rubygems' 
require 'stomp'
require 'json'
require 'csv'
require 'osgb_convert'
require 'active_support/core_ext/date/conversions'
require 'active_support/core_ext/numeric/time'
require 'net/http'
require 'dotenv'

Dotenv.load

# LOAD ALL THE CSVS
tiplocs = {}
CSV.read(File.join(File.dirname(__FILE__), 'data', 'tiplocs.csv')).each do |row|
  tiplocs[row[0]] = row[1]
end
stations = {}
CSV.read(File.join(File.dirname(__FILE__), 'data', 'RailReferences.csv'), :headers => true).each do |row|
  os_loc = OsgbConvert::OSGrid.new(row['Easting'].to_i, row['Northing'].to_i)
  ll_loc = os_loc.wgs84    
  stations[row['TiplocCode']] = {
    :name => row['StationName'],
    :location => ll_loc
  }
end
  
@port = 61618
@host = "datafeeds.networkrail.co.uk" 
@user = ENV['NETWORK_RAIL_API_USER']
@password = ENV['NETWORK_RAIL_API_PASSWORD']
  
@host = ENV["STOMP_HOST"] if ENV["STOMP_HOST"] != nil
@port = ENV["STOMP_PORT"] if ENV["STOMP_PORT"] != nil
  
@destination = "/topic/TRAIN_MVT_ALL_TOC"
@destination = $*[0] if $*[0] != nil

while true
  begin
    $stderr.print "Connecting to stomp://#{@host}:#{@port} as #{@user}\n" 
    @conn = Stomp::Connection.open @user, @password, @host, @port, true 
    $stderr.print "Connected to #{@destination}\n"
    @conn.subscribe @destination, { :ack =>"client" } 
    while true
      @msg = @conn.receive
      json = JSON.parse(@msg.body)
      json.each do |message|
        terminated = message['body']['train_terminated'] == 'true'
        train_id = message['body']['train_id']
        stanox = message['body']['loc_stanox']
        tiploc = tiplocs[stanox]
        station = stations[tiploc]
        if station && ["1","2","9"].include?(train_id[0])
          puts "train #{train_id} is at #{station[:name]} (#{station[:location].inspect})"
          if terminated
            puts ' -- TERMINATED'
          end
          # Look up schedule information
          response = Net::HTTP.get_response("api.traintimes.im","/locations.json?location=#{tiploc}&date=#{Date.today.iso8601}&startTime=#{5.minutes.ago.strftime('%H%M')}&period=30")
          if response.code == '200'
            schedule = JSON.parse(response.body)['services'].find{|x| x['trainIdentity'] == train_id.slice(2..5)}
            if schedule
              puts " -- #{schedule['origin']['departure_time']} #{schedule['origin']['description']} to #{schedule['destination']['description']}"  
            end
          end
          puts
        end
      end
      $stdout.flush
      @conn.ack @msg.headers["message-id"]
    end
    @conn.disconnect
  rescue
    sleep 1
  end
end 