require_relative 'block_model'

RSpec.describe BlockModel do
  let(:block_model) { BlockModel.new(blocks) }
  
  describe "reblock" do
    context "when blocks model is empty" do
      let(:blocks) { [] }

      it "reblocked blocks are also empty" do
        block_model.reblock(20, 20, 20)
        expect(block_model.blocks).to be_empty
      end
    end

    context "when blocks model has on block" do
      let(:blocks) { [ [ [ { mass: 12.0 } ]]] }

      it "reblocked model has one block, when rx=ry=rz=1" do
        block_model.reblock(1, 1, 1)
        expect(block_model.blocks).to eq blocks
      end
    end
  end
end
