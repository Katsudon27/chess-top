require_relative "../lib/board"
require_relative "../lib/pieces/pawn"

describe Board do
  subject(:chess_board) { described_class.import("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR") }

  let(:board) { chess_board.instance_variable_get(:@board) }

  describe "#move_piece" do
    let(:target) { board[4][4] }

    context "when pawn at e2 is moved to e4" do
      before do
        allow(target).to receive(:add_piece)
      end

      it "updates the board" do
        chess_board.populate_possible_moves("e2")
        chess_board.move_piece("e2", "e4")
        expect(target).to have_received(:add_piece).once
      end

      it "updates the en passant square" do
        chess_board.populate_possible_moves("e2")
        chess_board.move_piece("e2", "e4")
        expect(chess_board.en_passant_square).to eq("e3")
      end
    end

    context "when there is an en passant square but the opponent does not take the pawn" do
      it "removes the en passant square" do
        chess_board.populate_possible_moves("e2")
        chess_board.move_piece("e2", "e4")
        chess_board.move_piece("g7", "g6")
        expect(chess_board.en_passant_square).to eq("-")
      end
    end

    context "when the opponent does an en passant capture" do
      subject(:chess_board) { described_class.import("rnbqkbnr/ppp1pppp/8/8/3pP3/8/PPPP1PPP/RNBQKBNR") }

      let(:board) { chess_board.instance_variable_get(:@board) }
      let(:target_square) { board[4][4] }

      before do
        allow(target_square).to receive(:clear)
      end

      it "removes the piece from the target square" do
        chess_board.en_passant_square = "e3"
        chess_board.move_piece("d4", "e3")
        expect(target_square).to have_received(:clear).once
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

  describe "self.#import" do
    context "when called with a notation of move 1.e4 from starting position" do
      it "changes the current board positions to match the provided notation" do
        answer = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR"
        test_board = described_class.import(answer)
        expect(test_board.export).to eq(answer)
      end
    end
  end

  describe "#populate_possible_moves" do
    context "when called on pawn at e2" do
      let(:start) { board[6][4] }
      let(:square1) { board[5][4] }
      let(:pawn) { instance_double(Pawn) }

      before do
        allow(start).to receive(:piece).and_return(pawn)
        allow(pawn).to receive(:possible_moves).and_return(%w[e3 e4])
        allow(square1).to receive(:add_highlight)
      end

      it "calls #possible_moves on the pawn of e2" do
        chess_board.populate_possible_moves("e2")
        expect(pawn).to have_received(:possible_moves).once
      end

      it "calls #add_highlight on e3" do
        chess_board.populate_possible_moves("e2")
        expect(square1).to have_received(:add_highlight).once
      end
    end
  end
end
