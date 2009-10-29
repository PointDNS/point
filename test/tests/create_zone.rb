require File.join(File.dirname(__FILE__), '..', 'helper')
require 'digest'

class CreateZone < Test::Unit::TestCase
  
  def setup
    @zone = Point::Zone.new
    @zone.name = "apitest-#{Digest::SHA1.hexdigest(Time.now.to_s + rand(9999).to_s)[0,13]}.com"
  end
  
  def test_successful_zone_creation
    assert_equal true, @zone.save
    assert_equal nil, @zone.errors
    assert_instance_of Fixnum, @zone.id
    ## check it exists...
    new_zone = Point::Zone.find(@zone.id)
    assert_equal @zone.name, new_zone.name
  end
  
  def test_failed_zone_creation
    @zone.name = nil
    assert_equal false, @zone.save
    assert_equal true, @zone.errors.keys.include?('name')
  end
  
  def test_failed_zone_creation_on_ttl_size
    @zone.ttl = 1
    assert_equal false, @zone.save
    assert_equal true, @zone.errors.keys.include?('ttl')
  end
  
  def teardown
    ## You just have to hope the destroy method isn't broken ;)
    @zone.destroy
  end
  
end
