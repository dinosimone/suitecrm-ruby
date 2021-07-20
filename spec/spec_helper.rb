$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "suitecrm-ruby"
require "factory_bot"
require "vcr"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end
