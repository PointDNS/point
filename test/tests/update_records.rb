require File.join(File.dirname(__FILE__), '..', 'helper')

class UpdateRecords < Test::Unit::TestCase
  
  def setup
    @zone = Point::Zone.find(194) ## pointhq-apitest1.com
    @record = @zone.record(1760)
  end
  
  def test_data_change
    @record.data = '9.9.9.9'
    assert @record.save
    new_record = @zone.record(1760)
    assert_equal new_record.data, @record.data
  end
      
  def teardown
    @record.data = "2.2.2.2"
    @record.save
  end
  
end
