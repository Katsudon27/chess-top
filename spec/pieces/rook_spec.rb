require_relative "../../lib/pieces/rook"

describe Rook do
  subject(:rook) { described_class.new("\u2656") }

  describe "#possible_moves" do
    context "when the piece is at a1" do
      it "returns an array of coordinates of possible moves that can be made" do
        expect(rook.possible_moves("a1").sort).to eq(%w[a2 a3 a4 a5 a6 a7 a8 b1 c1 d1 e1 f1 g1 h1].sort)
      end
    end

    context "when the piece is at e4" do
      it "returns an array of coordinates of possible moves that can be made" do
        expect(rook.possible_moves("e4").sort).to eq(%w[a4 b4 c4 d4 f4 g4 h4 e1 e2 e3 e5 e6 e7 e8].sort)
      end
    end
  end
end
