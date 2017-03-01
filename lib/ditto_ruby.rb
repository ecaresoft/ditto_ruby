require 'ditto/version'
require 'ditto/issuer'

module Ditto
  @api_key = 'benoror'
  @base_url = 'http://d9d5452e.ngrok.io'
  @base_path = '/Api/webresources/invoice'

  class << self
    attr_accessor :api_key, :base_url, :base_path
  end
end
