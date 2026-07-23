require_relative "../../lib/pieces/king"

describe King do
  subject(:king) { described_class.new("\u2654") }

  describe "#possible_moves" do
    context "when the piece is at e4" do
      it "returns an array of coordinates of possible moves that can be made" do
        expect(king.possible_moves("e4").sort).to eq(%w[d3 d4 d5 e3 e5 f3 f4 f5].sort)
      end
    end
  end
end
