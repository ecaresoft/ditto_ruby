module Ditto
  class Emisor
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def create(params = {})
      client.request(:post, "/SaveEmisorMaster/Emisor?UserId=#{client.api_key}", params)
    end
  end
end
