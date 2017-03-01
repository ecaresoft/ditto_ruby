require 'spec_helper'

describe Ditto::Emisor do
  let(:client) { Ditto::Client.new(url: URL, api_key: API_KEY, base_path: BASE_PATH) }
  let(:emisor) { Ditto::Emisor.new(client) }

  let(:attributes) do
    {
      name: 'Benjamin Orozco Rios',
      rfc: 'OORB861120',
      regimen: 'simplificado',
      userNameSF: 'benoror+test@gmail.com',
      passwordSF: 'benorortesttest',
      satPass: '12345678a',
      production: false,
      location: {
        street: 'calle siempre viva 4444',
        postalCode: '03240',
        townCouncil: 'BENITO JUAREZ',
        streetNumber: 'No. 140',
        apartmentNumber: '5',
        country: 'Mexico',
        active: true,
        state: 'DISTRITO FEDERAL',
        address: 'ACACIAS'
      },
      fiscalLocation: {
        street: 'AV. UNIVERSIDAD 4444',
        postalCode: '03910',
        address: 'OXTOPULCO',
        state: 'DISTRITO FEDERAL',
        streetNumber: '1858',
        apartmentNumber: '2',
        country: 'Mexico',
        active: true
      },
      active: true
    }
  end

  describe '#create' do
    it 'creates an emisor', :vcr do
      response = emisor.create(attributes)
      expect(response.keys).to include('id')
    end
  end
end
