module Point
  class ZoneRecord < Base

    RECORD_TYPES = ["A", "CNAME", "MX", "TXT", "SRV", "AAAA", 'SSHFP']
    
    class << self
      def collection_path(params = {})
        "zones/#{params[:zone].id}/records"
      end
      
      def member_path(id, params = {})
        "zones/#{params[:zone].id}/records/#{id}"
      end
      
      def class_name
        "zone_record"
      end
    end
    
    def default_params
      {:zone => self.zone}
    end
    
  end
end
