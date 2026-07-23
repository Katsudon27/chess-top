require_relative "../../lib/pieces/bishop"

describe Bishop do
  subject(:bishop) { described_class.new("\u2657") }

  describe "#possible_moves" do
    context "when the piece is at d4" do
      it "returns an array of coordinates of possible moves that can be made" do
        expect(rook.possible_moves("e4").sort).to eq(%w[c5 b6 a7 a1 b2 c3 e3 f2 g1 e5 f6 g7 h8].sort)
      end
    end
  end
end
