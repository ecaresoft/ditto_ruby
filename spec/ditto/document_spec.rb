require 'spec_helper'

describe Ditto::Document do
  let(:issuer) do
    Ditto::Issuer.create(
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
    )
  end

  let(:attributes) do
    {
      receptor: { id: 'A74B6' },
      documentNo: '11223344',
      version: '3.2',
      regimen: 'simplificado',
      paymentForm: 'PAGO EN UNA SOLA EXHIBICION',
      voucherType: 'ingreso',
      paymentMethod: '01',
      expeditionPlace: 'Mexico',
      subTotal: 1000,
      total: 1160,
      active: true,
      concepts: [],
      tax: []
    }
  end

  context 'issuer' do
    describe '#create_document' do
      it 'must have a create_document method', :vcr do
        expect(issuer).to respond_to(:create_document)
      end

      it 'fails to create empty document', :vcr do
        expect { issuer.create_document({}) }.to raise_error(Faraday::ClientError)
      end

      it 'succeed to create a document', :vcr do
        document = issuer.create_document(attributes)
        expect(document.id).to_not be_nil
      end
    end

    describe '#find_document' do
      it 'must have a find_document method', :vcr do
        expect(issuer).to respond_to(:find_document)
      end

      it 'fails to find an unknown document', :vcr do
        expect { issuer.find_document('123') }.to raise_error(Faraday::ClientError)
      end

      it 'succeed to find an existing document', :vcr do
        document1 = issuer.create_document(attributes)
        document2 = issuer.find_document(document1.id)
        expect(document2.id).to_not be_nil
      end
    end

    # describe '#all' do
    #   # SearchDocumentList
    # end
  end
end
