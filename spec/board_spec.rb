require_relative "../lib/board"
require_relative "../lib/pieces/knight"

describe Board do
  subject(:chess_board) { described_class.new }

  let(:board) { chess_board.instance_variable_get(:@board) }

  describe "#move_piece" do
    context "when pawn at e2 is moved to e4" do
      let(:start) { board[6][4] }
      let(:target) { board[4][4] }
      let(:knight) { instance_double(Knight) }

      before do
        allow(start).to receive(:piece).and_return(knight)
        allow(target).to receive(:add_piece)
      end

      it "updates the board" do
        chess_board.move_piece("e2", "e4")
        expect(target).to have_received(:add_piece).once
      end
    end
  end

  describe "#export" do
    context "when at starting position" do
      it "returns the correct notation" do
        answer = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR"
        expect(chess_board.export).to eq(answer)
      end
    end

    context "when pawn at e2 is moved to e4" do
      before do
        chess_board.move_piece("e2", "e4")
      end
      it "returns the correct notation" do
        answer = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR"
        expect(chess_board.export).to eq(answer)
      end
    end
  end
end
