require_relative "../../lib/pieces/pawn"

describe Pawn do
  subject(:pawn) { described_class.new("\u2659") }

  describe "#possible_moves" do
    context "when the piece is at original position of d2" do
      it "can take one or two step forward" do
        expect(king.possible_moves("d2")).to eq(%w[d3 d4])
      end
    end

    context "when the piece is at d3" do
      it "can only take one step forward" do
        expect(king.possible_moves("d2")).to eq(%w[d3 d4])
      end
    end
  end
end
