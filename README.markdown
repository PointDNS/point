#PointHQ API Library

This library provides easy access to point zone & record management. For information about the 
services offered on Point see [the website](http://pointhq.com)

##Setup & Installation

Install the Gem:

    [sudo] gem install point --source=http://gemcutter.org

To access your PointHQ account, you'll need to define your username & API token. The API token
can be found in your profile page (click on your name in the top right of the web interface).

    Point.username = "adam@atechmedia.com"
    Point.apitoken = "pe97hq3ugc3vplztg7cyqc3rc6z47j8i1lxlssx7"
    
##Working with the API

All zone & record information is returned as an instance of either `Point::Zone` or `Point::ZoneRecord`. 
You can access variables by accessing `Point::Zone#attribute_name` when appropriate.

###Zones

The available attributes on the zones model are:

* `id` - the ID of the zone
* `name` - the domain name
* `ttl` - TTL for the zone (defaults to 3600)
* `additional_slaves` - any additional slave servers you have configured
* `group` - the group this zone belongs to
* `user_id` - the ID of the user who created it (this will be you)
* `last_updated_on_server` - the last time this record was applied to go live
* `serial` - the current serial number for the zone

Various usage examples:
  
    require 'point'
    Point::Zone.find(:all) #=> [<Point::Zone:...../>, <Point::Zone:...../>]
    Point::Zone.find(123)  #=> <Point::Zone:...../>
    
    z = Point::Zone.new
    z.name = "mycoolzone.com"
    if z.save
      puts "Zone was created successfully."
    else
      for key, error in z.errors
        puts "#{key} #{error}"
      end
    end

    z.destroy
    
###Zone Records

The available attributes on a zone record are:

* `id` - record ID
* `name` - FQDN for the record
* `data` - data field
* `ttl` (not used)
* `aux` - the AUX data for the domain (used on MX records)
* `zone_id` - the ID of the zone

Various usage examples:

    zone = Point::Zone.find(123)
    records = zone.records #=> [<Point::ZoneRecord:...../>, <Point::ZoneRecord:...../>]
    record = zone.record(1234)
    record.zone            #=> <Point::Zone:...../>
    record.save            #=> true or false
    record.destroy         #=> true or false

    new_record = zone.build_record
    new_record.record_type = "A"
    new_record.name = "example"
    new_record.data = "123.123.123.123"
    new_record.save       #=> true | false
    new_record.errors     #=> {'data' => 'is invalid', 'aux' => 'is blank'}

    zone.requires_update? => true if outstanding changes need to be applied
    zone.apply!           => push changes to DNS servers
