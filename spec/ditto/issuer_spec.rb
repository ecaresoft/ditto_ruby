require 'spec_helper'

describe Ditto::Issuer do
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
      it 'creates an emisor', :vcr do
        response = Ditto::Issuer.create(attributes)
        expect(response.keys).to include('id')
      end
    end

    context 'without attributes' do
      let(:emisor) { Ditto::Issuer.new(client) }

      it 'fails to create an emisor', :vcr do
        attributes.delete(:rfc)
        expect { Ditto::Issuer.create(attributes) }.to raise_error(Faraday::ClientError)
      end
    end
  end

  describe '#fetch' do
    it 'fetches an emisor' do
      pending('pending to implement')
      response = Ditto::Issuer.find(attributes[:id])
    end
  end
end
