require 'ostruct'
require 'govuk/dummy_content_store'
require 'erb'

module Govuk
  module DummyContentStore
    class Index
      attr_reader :example_repository

      def initialize(example_repository)
        @example_repository = example_repository
      end

      def call(env)
        if env["PATH_INFO"] == "/"
          render_index
        else
          [404, {}, ["Not found"]]
        end
      end

    private
      def render_index
        status = 200
        body = render_template("index.html.erb", examples: example_repository.all)
        headers = {
          'Content-Type' => 'text/html; charset=utf-8',
          'Content-Length' => body.bytesize.to_s,
          'Cache-control' => 'no-cache'
        }
        [status, headers, [body]]
      end

      def load_template(name)
        File.read(File.dirname(__FILE__) + "/templates/#{name}", encoding: "UTF-8")
      end

      class CleanBinding < OpenStruct
        include ERB::Util

        def binding
          Kernel.binding
        end
      end

      def render_template(template_name, vars)
        template = load_template(template_name)
        ERB.new(template).result(CleanBinding.new(vars).binding)
      end
    end
  end
end
