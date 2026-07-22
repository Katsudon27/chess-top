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
end
