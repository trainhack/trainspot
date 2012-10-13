## Network Rail importer

Parses data from Network Rail's TRUST feed to work out where trains are.

Combines this with a handy STANOX->TIPLOC CSV file from [Tom Cairns](http://www.thomas-cairns.co.uk/), NAPTAN for TIPLOC locations, and schedule data from Tom's [RailMiles API](http://api.traintimes.im).

Dumps the resulting data into MongoDB to give a list of trains and where they are at any time. (Soon)

###Configuration

Set ENV vars for NETWORK_RAIL_API_KEY and NETWORK_RAIL_API_PASSWORD

###Running

    ruby network_rail.rb
    
###Data

data/tiploc.csv is processed from Network Rail data by [Tom Cairns](http://www.thomas-cairns.co.uk/)

data/RailReferences.csv is from [NAPTAN](http://data.gov.uk/dataset/naptan)