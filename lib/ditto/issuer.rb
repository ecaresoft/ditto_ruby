require 'ditto/client'

class Ditto::Issuer
  ATTRIBUTES = [:id, :name, :rfc, :regimen, :userNameSF, :passwordSF, :satPass,
                :production, :location, :fiscalLocation]
  attr_accessor(*ATTRIBUTES)

  def initialize(attrs = {})
    attrs.each do |key, value|
      send("#{key}=", value) if respond_to? key
    end
  end

  def self.create(attrs = {})
    new(attrs).save
  end

  def save
    if id.nil?
      client.post("/SaveEmisorMaster/Emisor?UserId=#{Ditto.api_key}", to_hash)
    end
  end

  private
  def client
    @client ||= Ditto::Client.new
  end

  def to_hash
    attrs = {}

    ATTRIBUTES.each do |a|
      value = send("#{a}")
      attrs[a] = value if !value.nil?
    end

    attrs
  end
end
