require_relative "../../lib/pieces/queen"

describe Queen do
  subject(:queen) { described_class.new("\u2655") }

  describe "#possible_moves" do
    context "when the piece is at e4" do
      it "returns an array of coordinates of possible moves that can be made" do
        horizontal_and_vertical = %w[a4 b4 c4 d4 f4 g4 h4 e1 e2 e3 e5 e6 e7 e8]
        diagonal = %w[d5 c6 b7 a8 d3 c2 b1 f3 g2 h1 f5 g6 h7]
        expect(queen.possible_moves("e4").sort).to eq((horizontal_and_vertical + diagonal).sort)
      end
    end
  end
end
