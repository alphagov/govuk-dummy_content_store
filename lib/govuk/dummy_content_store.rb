require "govuk/dummy_content_store/version"

module Govuk
  module DummyContentStore
    autoload :Content, "govuk/dummy_content_store/content"
    autoload :ExampleContentItem, "govuk/dummy_content_store/example_content_item"
    autoload :ExampleRepository, "govuk/dummy_content_store/example_repository"
    autoload :LiveRepository, "govuk/dummy_content_store/live_repository"
    autoload :Index, "govuk/dummy_content_store/index"
  end
end
