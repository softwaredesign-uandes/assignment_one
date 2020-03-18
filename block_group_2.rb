class BlockGroup < AbstractBlock
  def initialize(blocks)
    @blocks = blocks
  end

  def value(key)
    blocks.map { |b| b.value(key) }.sum
  end
end