require 'spec_helper'

describe Ditto::Emisor do
  let(:client) { Ditto::Client.new(url: URL, api_key: API_KEY, base_path: BASE_PATH) }

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
    context 'with attributes' do
      let(:emisor) { Ditto::Emisor.new(client) }

      it 'creates an emisor', :vcr do
        response = emisor.create(attributes)
        expect(response.keys).to include('id')
      end
    end

    context 'without attributes' do
      let(:emisor) { Ditto::Emisor.new(client) }

      it 'fails to create an emisor', :vcr do
        attributes.delete(:rfc)
        expect { emisor.create(attributes) }.to raise_error(Faraday::ClientError)
      end
    end
  end

  describe '#fetch' do
    it 'fetches an emisor' do
      pending('pending to implement')
      response = Ditto::Emisor.fetch(client, attributes[:id])
    end
  end
end
