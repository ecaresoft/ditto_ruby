require 'ditto/base'

class Ditto::Issuer < Ditto::Base
  attr_accessor :id, :name, :rfc, :regimen, :userNameSF, :passwordSF, :satPass,
                :production, :location, :fiscalLocation, :key

  def initialize(attrs = {})
    super(attrs)
    @create_path = "SaveEmisorMaster/Emisor?UserId=#{Ditto.api_key}"
  end

  def save
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

    client.post("SaveEmisorConfigurationMaster/Configuration?UserId=#{Ditto.api_key}",
                { emisorId: id, sessionDuration: 24 }) if no_config

    client.refresh_token = key
  end

  def find_document(id)
    Ditto::Document.find(self, id)
  end

  def create_document(attrs)
    Ditto::Document.create(self, attrs)
  end
end
