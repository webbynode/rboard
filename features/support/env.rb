# Sets up the Rails environment for Cucumber
ENV["RAILS_ENV"] ||= "test"
this = File.expand_path(File.dirname(__FILE__))
require this + '/../../config/environment'
require 'cucumber/rails/world'
require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support
Cucumber::Rails.use_transactional_fixtures
Cucumber::Rails.bypass_rescue # Comment out this line if you want Rails own error handling 
                              # (e.g. rescue_action_in_public / rescue_responses / rescue_from)

this = File.expand_path(File.dirname(__FILE__))
require File.join(this, 'blueprints')
require 'webrat'
require 'faker'
require 'machinist'

# Require extensions in the ext directory
Dir[File.join(this, 'ext') + "/*.rb"].each do |file|
  require file
end

Webrat.configure do |config|
  config.mode = :rails
end

require 'cucumber/rails/rspec'
require 'webrat/core/matchers'
