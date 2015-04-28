require 'govuk/dummy_content_store/app'
require 'rack/test'

RSpec.describe "Dummy content store rack application" do
  include Rack::Test::Methods

  let(:schemas_path) { File.dirname(__FILE__) + "/../fixtures/govuk-content-schemas" }

  around(:each) do |example|
    old_env = ENV['EXAMPLES_PATH']
    ENV['EXAMPLES_PATH'] = schemas_path
    example.run
    ENV['EXAMPLES_PATH'] = old_env
  end

  let(:app) {
    Rack::Builder.parse_file('config.ru').first
  }

  it "serves the example from the /content/<base_path>" do
    get '/content/my-example'
    expect(last_response).to be_ok
    expect(last_response.body).to eq(File.read(schemas_path + "/formats/my-format/frontend/examples/my_example.json", encoding: "UTF-8"))
  end

  it "responds with 404 for unknown paths" do
    get '/content/non-existent-example'
    expect(last_response.status).to eq(404)
  end
end
