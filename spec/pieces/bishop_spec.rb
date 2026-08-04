require_relative "../../lib/pieces/bishop"
require_relative "../../lib/board"

describe Bishop do
  subject(:bishop) { described_class.new("white") }

  describe "#possible_moves" do
    context "when the piece is at d4" do
      let(:game_board) { Board.import("8/8/8/8/3B4/8/8/8") }

      it "returns an array of coordinates of possible moves that can be made" do
        expect(bishop.possible_moves("d4", game_board).sort).to eq(%w[c5 b6 a7 a1 b2 c3 e3 f2 g1 e5 f6 g7 h8].sort)
      end
    end

    context "when the piece is at c2 and there are friendly pieces around it" do
      let(:game_board) { Board.import("8/8/8/8/8/1NPP4/1KBN4/1RQB4") }

      it "returns an empty array" do
        expect(bishop.possible_moves("c2", game_board)).to be_empty
      end
    end

    context "when the piece is at c3 and there is an enemy piece on f6" do
      let(:game_board) { Board.import("8/8/5q2/8/8/2B5/8/8") }

      it "returns an array of moves but does not include moves past the enemy piece" do
        expect(bishop.possible_moves("c3", game_board).sort).to eq(%w[a1 a5 b2 b4 d2 d4 e1 e5 f6].sort)
      end
    end
  end
end
