require 'ditto/client'

class Ditto::Base
  @create_path = ''
  @update_path = ''

  def initialize(attrs = {})
    attrs.each do |key, value|
      send("#{key}=", value) if respond_to? key
    end
  end

  def self.create(attrs = {})
    instance = new(attrs)
    instance.save
    instance
  end

  def save
    response =
      if id.nil?
        client.post(@create_path, to_hash)
      else
        client.put(@update_path, to_hash)
      end

    response.each do |key, value|
      send("#{key}=", value) if respond_to? key
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
      attrs[a] = value unless value.nil?
    end

    attrs
  end
end
