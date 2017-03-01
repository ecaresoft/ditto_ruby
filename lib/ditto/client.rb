require 'faraday'
require 'faraday_middleware'

class Ditto::Client
  def get(path, params = {})
    connection.get do |request|
      request.url "#{Ditto.base_path}/#{path}"
      request.headers['Content-Type'] = 'application/json'
      params.each { |key, val| request.params[key] = val }
    end.body
  end

  def put(path, params = {})
    connection.put do |request|
      request.url "#{Ditto.base_path}/#{path}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end.body
  end

  def post(path, params = {})
    connection.post do |request|
      request.url "#{Ditto.base_path}/#{path}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end.body
  end

  def connection
    @connection ||= Faraday.new(url: Ditto.base_url) do |c|
      c.adapter Faraday.default_adapter
      c.use Faraday::Response::RaiseError
      c.response :json, content_type: /\bjson$/
    end
  end
end
