$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ditto_ruby'

require 'rspec'
require 'webmock/rspec'
require 'vcr'
require 'pry'

URL = 'http://d9d5452e.ngrok.io'
API_KEY = 'benoror'
BASE_PATH = '/Api/webresources/invoice'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock
  c.default_cassette_options = { match_requests_on: [:method] }
  c.configure_rspec_metadata!
end
