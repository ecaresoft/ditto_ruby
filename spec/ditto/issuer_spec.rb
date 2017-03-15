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
      it 'succeed to create an issuer', :vcr do
        issuer = Ditto::Issuer.create(attributes)
        expect(issuer.id).to_not be_nil
      end
    end

    context 'without attributes' do
      it 'fails to create an issuer', :vcr do
        attributes.delete(:rfc)
        expect { Ditto::Issuer.create(attributes) }.to raise_error(Faraday::ClientError)
      end
    end
  end

  describe '#find' do
    it 'fails to find an unknown issuer', :vcr do
      pending('pending to implement')
      expect { Ditto::Issuer.find('123') }.to raise_error(Faraday::ClientError)
    end

    it 'succeed to find an issuer', :vcr do
      pending('pending to implement')
      issuer1 = Ditto::Issuer.create(attributes)
      issuer2 = Ditto::Issuer.find(issuer1.id)
      expect(issuer2.id).to_not be_nil
    end
  end
end
