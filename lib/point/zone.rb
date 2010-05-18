module Point
  class Zone < Base
    
    def apply!
      $stderr.puts "Zone information does not need to be applied manually. Point::Zone#apply! method will be deprecated soon."
      true
    end
    
    def records
      ZoneRecord.find(:all, :zone => self)
    end
    
    def record(id)
      ZoneRecord.find(id, :zone => self)
    end
    
    def build_record(attributes = {})
      z = ZoneRecord.new
      z.attributes = attributes if attributes.is_a?(Hash)
      z.zone = self
      z
    end
    
    def requires_update?
      $stderr.puts "Zone updated are applied immediately. Point::Zone#requires_update? will be deprecated soon."
      false
    end
  end
end
