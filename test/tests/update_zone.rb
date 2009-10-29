require File.join(File.dirname(__FILE__), '..', 'helper')

class UpdaetZone < Test::Unit::TestCase
  
  def setup
    @zone = Point::Zone.find(194) ## pointhq-apitest1.com
  end
  
  def test_ttl_change
    @zone.ttl = 9999
    assert_equal true, @zone.save
    ## get it again and see if it's OK...
    new_zone = Point::Zone.find(194)
    assert_equal 9999, new_zone.ttl
  end
      
  def teardown
    @zone.ttl = 3600
    @zone.save
  end
  
end
