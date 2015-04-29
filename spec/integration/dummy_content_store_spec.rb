require 'rack/test'

RSpec.describe "Dummy content store rack application" do
  include Rack::Test::Methods

  let(:schemas_path) { File.dirname(__FILE__) + "/../fixtures/govuk-content-schemas" }
  let(:example_file_path) { schemas_path + "/formats/my-format/frontend/examples/my_example.json" }
  let(:example_file_base_path) { "/my-example" }
  let(:example_file_body) { File.read(example_file_path, encoding: "UTF-8") }

  around(:each) do |example|
    old_env = ENV['GOVUK_CONTENT_SCHEMAS_PATH']
    ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = schemas_path
    example.run
    ENV['GOVUK_CONTENT_SCHEMAS_PATH'] = old_env
  end

  let(:app) {
    Rack::Builder.parse_file('config.ru').first
  }

  it "serves the example from the /content/<base_path>" do
    get "/content#{example_file_base_path}"
    expect(last_response).to be_ok
    expect(last_response.body).to eq(example_file_body)
  end

  it "responds with 404 for unknown paths" do
    get '/content/non-existent-example'
    expect(last_response.status).to eq(404)
  end

  context "public api" do
    it "serves the example from the /api/content/<base_path>" do
      get "/api/content#{example_file_base_path}"
      expect(last_response).to be_ok
      expect(last_response.body).to eq(example_file_body)
    end
  end
end
