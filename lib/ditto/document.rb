require 'ditto/base'

class Ditto::Document < Ditto::Base
  attr_accessor :id, :receptor, :documentNo, :version, :regimen,
                :paymentForm, :voucherType, :paymentMethod, :expeditionPlace,
                :subTotal, :total, :active

  def self.find(issuer, id)
    attrs = issuer.client.get("SearchDocument/#{id}?Token=#{issuer.client.token}")

    Ditto::Document.new(attrs)
  end

  def self.create(issuer, attrs)
    instance = new(attrs)
    instance.save(issuer.client)
    instance
  end

  def save(client)
    @create_path = "SaveDocument/document?Token=#{client.token}"

    no_config = id.nil?

    response =
      if no_config
        client.post(@create_path, to_hash)
      else
        client.put(@update_path, to_hash)
      end

    response.each do |key, value|
      send("#{key}=", value) if respond_to? key
    end
  end
end
