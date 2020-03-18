require_relative 'block_model'

RSpec.describe BlockModel do
  let(:block_model) { BlockModel.new(blocks) }
  
  describe "reblock" do
    context "when blocks list is empty" do
      let(:blocks) { [] }

      it "reblocked blocks are also empty" do
        block_model.reblock(20, 20, 20)
        expect(block_model.blocks).to be_empty
      end
    end
  end
end
