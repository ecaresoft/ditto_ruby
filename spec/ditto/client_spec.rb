require 'spec_helper'

describe Ditto::Client do
  it 'catches HTTP 500 errors', :vcr do
    expect { Ditto::Issuer.create }.to raise_error(
      Faraday::ClientError, 'the server responded with status 500'
    )
  end
end
