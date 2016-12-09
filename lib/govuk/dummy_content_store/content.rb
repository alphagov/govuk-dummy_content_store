require 'pathname'
require 'json'
require 'govuk/dummy_content_store'
require 'net/http'
require 'govuk_schemas'

 # needed for govuk_schemas, can be removed after that gem is updated
require 'securerandom'

module Govuk
  module DummyContentStore
    class Content
      attr_reader :repository
      attr_reader :live_repository
      attr_reader :random_repository

      def initialize(repository, random_repository, live_repository = nil)
        @repository = repository
        @random_repository = random_repository
        @live_repository = live_repository
      end

      def call(env)
        example = repository.find_by_base_path(env["PATH_INFO"])
        if example
          present_example(example)
        elsif env["PATH_INFO"].start_with?("/random")
          random_example_json = random_repository.generate(env["PATH_INFO"].split('/').last)
          present_live(random_example_json)
        elsif live_repository && res = live_repository.find_by_base_path(env["PATH_INFO"])
          present_live(res.body)
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

      def present_live(body)
        headers = {
          'Content-Type' => 'application/json; charset=utf-8',
          'Content-Length' => body.size.to_s,
          'Cache-control' => 'no-cache'
        }

        [200, headers, [body]]
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
