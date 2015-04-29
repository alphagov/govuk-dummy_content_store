require 'pathname'
require 'json'
require 'govuk/dummy_content_store'

module Govuk
  module DummyContentStore
    class Index
      attr_reader :formats_path

      def initialize(formats_path)
        @formats_path = Pathname.new(formats_path)
      end
    end
  end
end
