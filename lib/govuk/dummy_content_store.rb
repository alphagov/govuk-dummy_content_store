require "govuk/dummy_content_store/version"

module Govuk
  module DummyContentStore
    autoload :Content, "govuk/dummy_content_store/content"
    autoload :ExampleContentItem, "govuk/dummy_content_store/example_content_item"
    autoload :ExampleRepository, "govuk/dummy_content_store/example_repository"
  end
end
