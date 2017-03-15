require 'ditto/version'
require 'ditto/issuer'
require 'ditto/document'

module Ditto
  @api_key = 'benoror'
  @base_url = 'http://localhost:8080'
  @base_path = '/Api-1.0-SNAPSHOT/webresources/invoice'

  class << self
    attr_accessor :api_key, :base_url, :base_path
  end
end
