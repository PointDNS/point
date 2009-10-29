require File.join(File.dirname(__FILE__), '..', 'helper')

class Zones < Test::Unit::TestCase

  def test_getting_single_zone
    zone = Point::Zone.find(194) ## pointhq-apitest1.com
    assert_equal "pointhq-apitest1.com", zone.name
    assert_equal 3600, zone.ttl
    assert_equal "", zone.group
  end
  
  def test_getting_zones
    zones = Point::Zone.find(:all)
    assert zones.is_a?(Array)
    assert zones.size >= 2
  end
  
  def test_zone_applys
    zone = Point::Zone.find(194)
    assert zone.apply!
  end
    
end
