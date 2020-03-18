class Block < AbstractBlock
  def initialize(attributes)
    @attributes = attributes
  end

  def value(key)
    @attributes[key]
  end
end