require 'ditto/base'

class Ditto::Document < Ditto::Base
  attr_accessor :id, :receptor, :documentNo, :version, :regimen,
                :paymentForm, :voucherType, :paymentMethod, :expeditionPlace,
                :subTotal, :total, :active

  private
  def create_path
    "SaveDocument/document?Token=#{client.token}"
  end

  def update_path
    "SaveDocument/document?Token=#{client.token}"
  end

  def delete_path
    "DeleteDocument/#{id}?Token=#{client.token}"
  end
end
