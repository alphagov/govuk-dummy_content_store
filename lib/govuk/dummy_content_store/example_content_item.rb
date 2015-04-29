require 'govuk/dummy_content_store'

module Govuk
  module DummyContentStore
    class ExampleContentItem
      attr_reader :path

      def initialize(path)
        @path = path
      end

      def filename
        File.basename(path)
      end

      def base_path
        data["base_path"]
      end

      def format
        data["format"]
      end

      def title
        data["title"]
      end

      def view_url
        "/content#{base_path}"
      end

      def data
        JSON.parse(raw_data)
      end

      def raw_data
        File.read(path, encoding: "UTF-8")
      end
    end
  end
end
