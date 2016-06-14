require 'rack/test'
require 'nokogiri'

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

  describe "index page" do
    before(:each) { get "/" }

    it "responds with 200 OK" do
      expect(last_response).to be_ok
    end

    it "has content-type text/html charset utf8" do
      expect(last_response.headers['content-type']).to eq('text/html; charset=utf-8')
    end

    it "contains a list of all the examples" do
      doc = Nokogiri::HTML(last_response.body)

      bullets = doc.css('table tr td a').map { |elem| elem.content }

      expect(bullets).to eq(["Get Britain Building: Carlisle Park"])
    end
  end

  describe "css" do
    it "serves css" do
      get "/assets/styles.css"
      expect(last_response).to be_ok
    end
  end

  
  context "a fallback url is set" do
    before(:each) { ENV['DUMMY_CONTENT_STORE_FALLBACK_URL'] = "https://www.gov.uk/api/content" }
    
    it "serves the live content if the example is not available" do
      live_file_base_path = "/available"
      live_content_body = "stubbed response"
    
      get "/api/content#{live_file_base_path}"
      expect(last_response).to be_ok
      expect(last_response.body).to eq(live_content_body)
    end

    it "responds not found if both live and example are not available" do
      live_file_base_path = "/not-available"
      not_found_body = "Not found"
      
      get "/api/content#{live_file_base_path}"
      expect(last_response).not_to be_ok
      expect(last_response.status).to eq(404)
      expect(last_response.body).to eq(not_found_body)
    end
  end
end
