require_relative "../../lib/pieces/knight"
require_relative "../../lib/board"

describe Knight do
  subject(:knight) { described_class.new("white") }

  describe "#possible_moves" do
    context "when the piece is at e4" do
      let(:game_board) { Board.import("8/8/8/8/4N3/8/8/8") }

      it "returns an array of coordinates of possible moves that can be made" do
        expect(knight.possible_moves("e4", game_board).sort).to eq(%w[d6 c5 c3 d2 f2 g3 g5 f6].sort)
      end
    end
  end
end
