# frozen_string_literal: true
module Point
  class ZoneRedirect < Base
    RECORD_TYPES = [301, 302, 0].freeze

    class << self
      def collection_path(params = {})
        "zones/#{params[:zone].id}/redirects"
      end

      def member_path(id, params = {})
        "zones/#{params[:zone].id}/redirects/#{id}"
      end

      def class_name
        'zone_redirect'
      end
    end

    def default_params
      { zone: zone }
    end
  end
end
