require 'ditto/base'

class Ditto::Document < Ditto::Base
  attr_accessor :id, :receptor, :documentNo, :version, :regimen,
                :paymentForm, :voucherType, :paymentMethod, :expeditionPlace,
                :subTotal, :total, :active

  def initialize(attrs = {})
    super(attrs)
    @create_path =
      @update_path = "SaveDocument/document?Token=#{client.token}"
  end

  def delete
    @delete_path = "DeleteDocument/#{id}?Token=#{client.token}"
    super
  end
end
