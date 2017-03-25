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
    it 'fails to find an issuer with wrong token', :vcr do
      expect { Ditto::Issuer.find_with_token('123', 'meep') }.to raise_error(Faraday::ClientError)
    end

    it 'fails to find an unknown issuer', :vcr do
      issuer1 = Ditto::Issuer.create(attributes)
      expect { Ditto::Issuer.find_with_token('123', issuer1.token) }.to raise_error(Faraday::ClientError)
    end

    it 'succeed to find same issuer', :vcr do
      issuer1 = Ditto::Issuer.create(attributes)
      issuer2 = Ditto::Issuer.find_with_token(issuer1.id, issuer1.token)
      expect(issuer2.id).to eq(issuer1.id)
    end

    it 'succeed to find different issuer', :vcr do
      issuer1 = Ditto::Issuer.create(attributes)
      issuer2 = Ditto::Issuer.create(attributes)
      issuer3 = Ditto::Issuer.find_with_token(issuer1.id, issuer2.token)
      expect(issuer3.id).to eq(issuer1.id)
      expect(issuer3.id).to_not eq(issuer2.id)
    end
  end
end
