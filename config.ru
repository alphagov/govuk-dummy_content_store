#\ -p 3068
$LOAD_PATH << File.dirname(__FILE__) + "/lib"
require 'govuk/dummy_content_store'

govuk_content_schemas_path = ENV.fetch('GOVUK_CONTENT_SCHEMAS_PATH', ".")
repository = Govuk::DummyContentStore::ExampleRepository.new(govuk_content_schemas_path)

map '/content' do
  run Govuk::DummyContentStore::Content.new(repository)
end
map '/api/content' do
  run Govuk::DummyContentStore::Content.new(repository)
end
