require 'pathname'
require 'govuk/dummy_content_store'

module Govuk
  module DummyContentStore
    class ExampleRepository
      attr_reader :content_schemas_path

      def initialize(content_schemas_path)
        @content_schemas_path = Pathname.new(content_schemas_path)
      end

      def find_by_base_path(base_path)
        all.find { |item| item.base_path == base_path }
      end

      def all
        all_example_paths.lazy.map { |path| ExampleContentItem.new(path) }
      end

    private
      def all_example_paths
        Dir[content_schemas_path + "formats" + "**" + "examples" + "*.json"]
      end
    end
  end
end
