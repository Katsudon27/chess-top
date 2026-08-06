require_relative "../../lib/pieces/pawn"
require_relative "../../lib/board"

describe Pawn do
  subject(:pawn) { described_class.new("white") }

  describe "#possible_moves" do
    context "when the piece is at original position of d2" do
      let(:game_board) { Board.import("8/8/8/8/8/8/3P4/8") }

      it "can take one or two step forward" do
        expect(pawn.possible_moves("d2", game_board)).to eq(%w[d3 d4])
      end
    end

    context "when the piece has already moved to d3" do
      let(:game_board) { Board.import("8/8/8/8/8/3P4/8/8") }

      before do
        pawn.already_moved
      end

      it "can only take one step forward" do
        expect(pawn.possible_moves("d3", game_board)).to eq(%w[d4])
      end
    end

    context "when the piece has two enemy pieces on its front diagonal squares" do
      let(:game_board) { Board.import("rnbqkbnr/pppppp2/8/2p1p3/3P4/8/PPP1PPPP/RNBQKBNR") }

      before do
        pawn.already_moved
      end

      it "can attack both enemy pieces" do
        expect(pawn.possible_moves("d4", game_board).sort).to eq(%w[d5 e5 c5].sort)
      end
    end

    context "when the piece has an enemy piece in front of it" do
      let(:game_board) { Board.import("rnbqkbnr/ppp1pppp/8/8/8/3p4/PPPPPPPP/RNBQKBNR") }

      it "returns an empty array" do
        expect(pawn.possible_moves("d2", game_board)).to be_empty
      end
    end
  end

  describe "#promote" do
    context "when the piece is at opposing back row and player wants to promote it" do
      let(:game_board) { Board.import("P7/8/8/8/8/8/8/8") }

      horizontal = %w[b8 c8 d8 e8 f8 g8 h8]
      vertical = %w[a1 a2 a3 a4 a5 a6 a7]
      diagonal = %w[b7 c6 d5 e4 f3 g2 h1]

      before do
        pawn.already_moved
      end

      it "can be promoted to and move like a queen" do
        pawn.promote("Q")
        expect(pawn.possible_moves("a8", game_board).sort).to eq((horizontal + vertical + diagonal).sort)
      end

      it "can be promoted to and move like a bishop" do
        pawn.promote("B")
        expect(pawn.possible_moves("a8", game_board).sort).to eq(diagonal.sort)
      end

      it "can be promoted to and move like a rook" do
        pawn.promote("R")
        expect(pawn.possible_moves("a8", game_board).sort).to eq((horizontal + vertical).sort)
      end

      it "can be promoted to and move like a knight" do
        pawn.promote("N")
        expect(pawn.possible_moves("a8", game_board).sort).to eq(%w[b6 c7].sort)
      end
    end
  end
end
