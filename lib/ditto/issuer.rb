require 'ditto/base'
require 'ditto/resource'
require 'ditto/document'

class Ditto::Issuer < Ditto::Base
  attr_accessor :id, :name, :rfc, :regimen, :userNameSF, :passwordSF, :satPass,
                :production, :location, :fiscalLocation, :key

  def initialize(attrs = {})
    super(attrs)
  end

  def save
    no_config = id.nil?

    super

    if no_config
      client.post(
        "SaveEmisorConfigurationMaster/Configuration?UserId=#{Ditto.api_key}",
        { emisorId: id, sessionDuration: 24 }
      )
    end

    client.refresh_token = key
  end

  def self.find(id, token)
    client = Ditto::Client.new
    attrs = client.get("SearchEmisorById/#{id}?Token=#{token}")
    new(attrs)
  end

  def documents
    @documents ||=
      Ditto::Resource.new(
        Ditto::Document,
        client,
        "SearchDocument/{id}?Token=#{client.token}"
      )
  end

  def token
    client.token
  end

  private
  def create_path
    "SaveEmisorMaster/Emisor?UserId=#{Ditto.api_key}"
  end
end
