#\ -p 3068
$LOAD_PATH << File.dirname(__FILE__) + "/lib"
require 'govuk/dummy_content_store'

examples_path = ENV.fetch('EXAMPLES_PATH', ".")
repository = Govuk::DummyContentStore::ExampleRepository.new(examples_path)

map '/content' do
  run Govuk::DummyContentStore::Content.new(repository)
end
map '/api/content' do
  run Govuk::DummyContentStore::Content.new(repository)
end
