#\ -p 3068
$LOAD_PATH << File.dirname(__FILE__) + "/lib"
require 'govuk/dummy_content_store'

govuk_content_schemas_path = ENV.fetch('GOVUK_CONTENT_SCHEMAS_PATH', ".")
repository = Govuk::DummyContentStore::ExampleRepository.new(govuk_content_schemas_path)

map '/' do
  run Govuk::DummyContentStore::Index.new(repository)
end

# All /assets urls will serve files from the /public folder
map '/assets' do
  use Rack::Static, :urls => [""], :root => File.dirname(__FILE__) + "/public"

  # fallback always 404s
  run ->(_) { [404, {}, []] }
end

# Serve examples
map '/content' do
  run Govuk::DummyContentStore::Content.new(repository)
end
map '/api/content' do
  run Govuk::DummyContentStore::Content.new(repository)
end


