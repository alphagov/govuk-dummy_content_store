require "bundler/gem_tasks"

require "rspec/core/rake_task"
require "gem_publisher"

RSpec::Core::RakeTask.new(:spec)

desc "Publish gem to RubyGems.org"
task :publish_gem do |t|
  gem = GemPublisher.publish_if_updated("govuk-dummy_content_store.gemspec", :rubygems)
  puts "Published #{gem}" if gem
end

task :default => :spec
