require 'spec_helper'

describe Ditto::Client do
  let(:client) { Ditto::Client.new(api_key: API_KEY, url: URL, base_path: BASE_PATH) }
  let(:emisor) { Ditto::Emisor.new(client) }

  it 'catches HTTP 500 errors', :vcr do
    expect { emisor.create({}) }.to raise_error(Faraday::ClientError,
                                                'the server responded with status 500')
  end
end
