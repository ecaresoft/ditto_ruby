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
    describe '#documents create' do
      it 'documents must have a create method', :vcr do
        expect(issuer.documents).to respond_to(:create)
      end

      it 'fails to create empty document', :vcr do
        expect { issuer.documents.create({}) }.to raise_error(Faraday::ClientError)
      end

      it 'succeed to create a document', :vcr do
        document = issuer.documents.create(attributes)
        expect(document.id).to_not be_nil
      end
    end

    describe '#documents find' do
      it 'documents must have a find method', :vcr do
        expect(issuer.documents).to respond_to(:find)
      end

      it 'fails to find an unknown document', :vcr do
        expect { issuer.documents.find('123') }.to raise_error(Faraday::ClientError)
      end

      it 'succeed to find an existing document', :vcr do
        document1 = issuer.documents.create(attributes)
        document2 = issuer.documents.find(document1.id)
        expect(document2.id).to_not be_nil
      end
    end

    context 'document' do
      let(:document) do
        issuer.documents.create(attributes)
      end

      describe '#update' do
        it 'document must have an update method', :vcr do
          expect(document).to respond_to(:update)
        end

        it 'succeed to update an existing document', :vcr do
          pending('https://github.com/ecaresoft/ditto/issues/1')
          document.update({ name: 'Sifu' })
          expect(document.name).to equal('Sife')
        end
      end

      describe '#delete' do
        it 'documents must have a delete method', :vcr do
          expect(document).to respond_to(:delete)
        end

        it 'succeed to delete an existing document', :vcr do
          response = document.delete
          expect(response['status']).to equal(true)
        end
      end
    end

    # describe '#all' do
    #   # SearchDocumentList/{filters}
    # end
  end
end
