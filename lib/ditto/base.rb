require 'ditto/client'

class Ditto::Base
  @new_url = ''

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
      client.post(@new_url, to_hash)
    end
  end

  def self.attr_accessor(*vars)
    @attributes ||= []
    @attributes.concat vars
    super(*vars)
  end

  def self.attributes
    @attributes
  end

  def attributes
    self.class.attributes
  end

  protected
  def client
    @client ||= Ditto::Client.new
  end

  def to_hash
    attrs = {}

    attributes.each do |a|
      value = send("#{a}")
      attrs[a] = value if !value.nil?
    end

    attrs
  end
end
