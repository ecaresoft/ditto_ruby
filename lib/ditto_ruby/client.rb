require 'faraday'
require 'faraday_middleware'

module Ditto
  class Client
    attr_reader :api_key, :url, :base_path

    def initialize(options = {})
      @api_key = options[:api_key]
      @url = options[:url]
      @base_path = options[:base_path]
    end

    def request(type, path, params = {})
      block = proc do |request|
        request.url "#{base_path}#{path}"
        request.headers['Content-Type'] = 'application/json'
      end

      send("#{type}_request", path, params, &block)
    end

    private
    def put_request(_path, params = {}, &_block)
      connection.put do |request|
        yield(request)
        request.body = params.to_json
      end.body
    end

    def post_request(_path, params = {}, &_block)
      connection.post do |request|
        yield(request)
        request.body = params.to_json
      end.body
    end

    def get_request(_path, params = {}, &_block)
      connection.get do |request|
        yield(request)
        params.each { |key, val| request.params[key] = val }
      end.body
    end

    def connection
      @connection ||= Faraday.new(url: url) do |b|
        b.adapter Faraday.default_adapter
        b.use Faraday::Response::RaiseError
        b.response :json, content_type: /\bjson$/
      end
    end
  end
end
