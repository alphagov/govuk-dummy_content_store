require 'pathname'
require 'json'
require 'govuk/dummy_content_store'

module Govuk
  module DummyContentStore
    class Content
      attr_reader :formats_path

      def initialize(formats_path)
        @formats_path = Pathname.new(formats_path)
      end

      def call(env)
        example = find_example(env["PATH_INFO"])
        if example
          present_example(example)
        else
          present_not_found
        end
      end

      def find_example(url_path)
        all_examples.find { |e| e.base_path == url_path }
      end

    private
      def present_example(example)
        headers = {
          'Content-Type' => 'application/json; charset=utf-8',
          'Content-Length' => example.raw_data.bytesize.to_s,
          'Cache-control' => 'no-cache'
        }

        [200, headers, [example.raw_data]]
      end

      def present_not_found
        body = 'Not found'
        headers = {
          'Content-Type' => 'text/plain',
          'Content-Length' => body.size.to_s,
          'Cache-control' => 'no-cache'
        }
        [404, headers, [body]]
      end

      def all_example_paths
        Dir[formats_path + "**" + "examples" + "*.json"]
      end

      def all_examples
        all_example_paths.lazy.map { |path| ExampleContentItem.new(path) }
      end
    end
  end
end
