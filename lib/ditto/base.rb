require 'ditto/client'

class Ditto::Base
  @create_path = ''
  @update_path = ''
  @delete_path = ''

  def initialize(attrs = {})
    if attrs['client']
      @client = attrs['client']
      attrs.delete('client')
    end

    attrs.each do |key, value|
      send("#{key}=", value) if respond_to? key
    end
  end

  def self.find(id, opts = {})
    client = opts[:client]
    path = opts[:path].gsub('{id}', id)
    response = client.get(path)
    new(response)
  end

  def self.create(attrs = {})
    instance = new(attrs)
    instance.save
    instance
  end

  def update(attrs = {})
    attrs.each do |key, value|
      send("#{key}=", value) if respond_to? key
    end
    save
    self
  end

  def delete
    client.get(@delete_path)
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
      value = send(a.to_s)
      attrs[a] = value unless value.nil?
    end

    attrs
  end
end
