class Ditto::Resource
  def initialize(klass, client, path)
    @klass = klass
    @client = client
    @path = path
  end

  def find(id)
    @klass.find(id, client: @client, path: @path)
  end

  def create(attrs)
    attrs['client'] = @client
    @klass.create(attrs)
  end
end
