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
      let(:blocks) { [ [ [ { mass: 12.0 } ] ] ] }

      it "reblocked model has one block, when rx=ry=rz=1" do
        block_model.reblock(1, 1, 1)
        expect(block_model.blocks).to eq blocks
      end
    end

    context "when blocks model is 2x2x2" do
      let(:blocks) do
        [
          [
            [{mass: 1}, {mass: 1}],
            [{mass: 1}, {mass: 1}],
          ],
          [
            [{mass: 1}, {mass: 1}],
            [{mass: 1}, {mass: 1}],
          ]
        ]
      end

      context "when rx=ry=rz=1" do
        it "reblocked model has original blocks" do
          block_model.reblock(1, 1, 1)
          expect(block_model.blocks).to eq blocks
        end
      end

      context "when rx=ry=rz=2" do
        let(:expected_blocks) { [[[{ mass:8 }]]] }

        it "reblocked model has original blocks" do
          block_model.reblock(2, 2, 2)
          expect(block_model.blocks).to eq expected_blocks
        end
      end
    end
  end

  describe "reblock_no_fors" do
    let(:blocks) do
      [
        { mass: 1, x: 0, y: 0, z: 0},
        { mass: 1, x: 0, y: 0, z: 1},
        { mass: 1, x: 0, y: 1, z: 0},
        { mass: 1, x: 0, y: 1, z: 1},
        { mass: 1, x: 1, y: 0, z: 0},
        { mass: 1, x: 1, y: 0, z: 1},
        { mass: 1, x: 1, y: 1, z: 0},
        { mass: 1, x: 1, y: 1, z: 1},
      ]
    end

    let(:expected_blocks) { [{ mass: 8, x: 0, y: 0, z: 0 }] }

    it "returns expected blocks" do
      expect(block_model.reblock_no_fors(blocks, 2, 2, 2)).to eq(expected_blocks)
    end
  end
end
