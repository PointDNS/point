require File.join(File.dirname(__FILE__), '..', 'helper') 

class CreateRecords < Test::Unit::TestCase

  def setup
    @zone = Point::Zone.find(194) ## pointhq-apitest1.com
    @record = @zone.build_record
  end
  
  def test_new_record_creation
    assert @record.is_a?(Point::ZoneRecord)
    @record.record_type = 'A'
    @record.name = "newrecord.pointhq-apitest1.com."
    @record.data = "4.5.6.7"
    assert @record.save
    assert @record.id.is_a?(Fixnum)
  end
  
  def test_failed_record_creation
    @record.record_type = 'MX'
    @record.name = "mail"
    @record.data = "blah.mail.com."
    assert !@record.save
    assert @record.id.nil?
    assert @record.errors.keys.include?("aux")
  end
  
  def teardown
    assert @record.destroy unless @record.new_record?
  end
  
end
