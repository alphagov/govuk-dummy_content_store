require 'pathname'
require 'json'
require 'govuk/dummy_content_store'

module Govuk
  module DummyContentStore
    class Content
      attr_reader :repository

      def initialize(repository)
        @repository = repository
      end

      def call(env)
        example = repository.find_by_base_path(env["PATH_INFO"])
        if example
          present_example(example)
        else
          present_not_found
        end
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
    end
  end
end