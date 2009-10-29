require File.join(File.dirname(__FILE__), '..', 'helper')

class ZoneRecords < Test::Unit::TestCase

  def setup
    @zone = Point::Zone.find(194) ## pointhq-apitest1.com
  end
  
  def test_getting_records
    records = @zone.records
    assert @zone.records.is_a?(Array)
    assert @zone.records.first.is_a?(Point::ZoneRecord)    
  end
  
  def test_getting_one_record
    assert @zone.record(1760).is_a?(Point::ZoneRecord)
  end
  
end
