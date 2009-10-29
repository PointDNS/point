$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'test/unit'
require 'point'

Point.username = "apitest@pointhq.com"
Point.apitoken = `git config point.apitestkey`.chomp

puts "Working on '#{Point.site}' as '#{Point.username}'"
