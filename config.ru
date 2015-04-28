#\ -p 3068
$LOAD_PATH << File.dirname(__FILE__) + "/lib"
require 'govuk/dummy_content_store'

examples_path = ENV['EXAMPLES_PATH'] || File.dirname(__FILE__) + "/../formats"

map '/content' do
  run Govuk::DummyContentStore::App.new(examples_path)
end
