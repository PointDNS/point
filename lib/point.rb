## Require dependencies. All network traffic is processed using net/http and
## is transfered using JSON.
require 'json'
require 'uri'
require 'net/http'
require 'time'

## PointHQ Ruby API Client
## This is a ruby API client for the Point DNS hosting service.

require 'point/request'
require 'point/errors'
require 'point/base'
require 'point/zone'
require 'point/zone_record'

module Point
  VERSION = '1.0.0'
  
  class << self
    attr_accessor :username
    attr_accessor :apitoken
    attr_accessor :site
  end
  
end

Point.site = "https://pointhq.com"
