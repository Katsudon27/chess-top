require_relative "../lib/board"

describe Board do
  subject(:chess_board) { described_class.new }

  describe "#export" do
    context "when at starting position" do
      it "returns the correct notation" do
        answer = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
        expect(chess_board.export).to eq(answer)
      end
    end
  end
end
