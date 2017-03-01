require 'ditto/base'

class Ditto::Issuer < Ditto::Base
  attr_accessor :id, :name, :rfc, :regimen, :userNameSF, :passwordSF, :satPass,
                :production, :location, :fiscalLocation

  def initialize(attrs = {})
    super(attrs)
    @new_url = "SaveEmisorMaster/Emisor?UserId=#{Ditto.api_key}"
  end
end
