require_relative "../lib/coordinates"

describe Coordinates do
  subject(:coordinates) { described_class.new(0, 0) }

  describe "to_s" do
    context "when the coordinates is [0,0]" do
      it "returns a0" do
        expect(coordinates.to_s).to eq("a0")
      end
    end
  end

  describe "+(other)" do
    context "when added with an offset of [1,1]" do
      it "moves to b1" do
        offset = described_class.new(1, 1)
        result = coordinates + offset
        expect(result.to_s).to eq("b1")
      end
    end
  end
end
