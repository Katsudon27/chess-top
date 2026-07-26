require_relative "../../lib/pieces/pawn"

describe Pawn do
  subject(:pawn) { described_class.new("\u2659") }

  describe "#possible_moves" do
    context "when the piece is at original position of d2" do
      it "can take one or two step forward" do
        expect(pawn.possible_moves("d2")).to eq(%w[d3 d4])
      end
    end

    context "when the piece is at d3" do
      before do
        pawn.already_moved
      end

      it "can only take one step forward" do
        expect(pawn.possible_moves("d3")).to eq(%w[d4])
      end
    end
  end

  describe "#promote" do
    context "when the piece is at opposing back row and player wants to promote it" do
      horizontal = %w[b8 c8 d8 e8 f8 g8 h8]
      vertical = %w[a1 a2 a3 a4 a5 a6 a7]
      diagonal = %w[b7 c6 d5 e4 f3 g2 h1]

      before do
        pawn.already_moved
      end

      it "can be promoted to and move like a queen" do
        pawn.promote("Q")
        expect(pawn.possible_moves("a8").sort).to eq((horizontal + vertical + diagonal).sort)
      end

      it "can be promoted to and move like a bishop" do
        pawn.promote("B")
        expect(pawn.possible_moves("a8").sort).to eq(diagonal.sort)
      end

      it "can be promoted to and move like a rook" do
        pawn.promote("R")
        expect(pawn.possible_moves("a8").sort).to eq((horizontal + vertical).sort)
      end

      it "can be promoted to and move like a knight" do
        pawn.promote("N")
        expect(pawn.possible_moves("a8").sort).to eq(%w[b6 c7].sort)
      end
    end
  end
end
