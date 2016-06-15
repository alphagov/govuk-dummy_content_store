module Govuk
  module DummyContentStore
    class LiveRepository
      attr_reader :live_content_path

      def initialize(live_content_path)
        @live_content_path = live_content_path
      end

      def find_by_base_path(base_path)
        res = http_get(base_path)
        res.code == "404" ? nil : res
      end

    private
      def http_get(base_path)
        url = URI.parse(live_content_path + base_path)
        req = Net::HTTP::Get.new(url.to_s)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true if url.scheme == "https"
        http.request(req)
      end
    end
  end
end
