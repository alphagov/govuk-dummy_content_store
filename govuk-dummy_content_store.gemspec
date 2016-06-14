# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'govuk/dummy_content_store/version'

Gem::Specification.new do |spec|
  spec.name          = "govuk-dummy_content_store"
  spec.version       = Govuk::DummyContentStore::VERSION
  spec.authors       = ["David Heath"]
  spec.email         = ["david.heath@digital.cabinet-office.gov.uk"]
  spec.summary       = %q{Rack app which serves example files from govuk-content-schemas}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/alphagov/govuk-dummy_content_store"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.0'

  spec.add_dependency "rack"
  spec.add_dependency "rack-contrib"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "gem_publisher"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "webmock"
end
