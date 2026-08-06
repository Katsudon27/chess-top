require_relative "../lib/game_controller"
require_relative "../lib/board"
require_relative "../lib/player"
require_relative "../lib/square"
require_relative "../lib/pieces/knight"
require_relative "../lib/pieces/pawn"

describe GameController do
  subject(:game_controller) { described_class.new(first_player, second_player, game_board) }

  let(:first_player) { instance_double(Player) }
  let(:second_player) { instance_double(Player) }
  let(:game_board) { instance_double(Board) }
  let(:start_square) { instance_double(Square) }
  let(:pawn) { instance_double(Pawn) }

  before do
    allow(first_player).to receive(:color).and_return("white")
    allow(second_player).to receive(:color).and_return("black")
  end

  describe "#switch_turn" do
    context "when the current player is player 1" do
      it "switches to the other player as the current player" do
        game_controller.switch_turn
        expect(game_controller.instance_variable_get(:@current_player)).to eq(second_player)
      end
    end
  end

  describe "#valid_move?" do
    before do
      allow(game_board).to receive(:find_square).and_return(start_square)
      allow(start_square).to receive_messages(possible_moves: %w[e3 e4], piece: pawn)
      allow(pawn).to receive(:color).and_return("white")
      allow(first_player).to receive(:color).and_return("white")
      allow(second_player).to receive(:color).and_return("black")
    end

    context "when white wants to move pawn from e2 to e4" do
      it "returns true" do
        expect(game_controller.valid_move?("e2", "e4")).to be true
      end
    end

    context "when white wants to move pawn from e2 to e6" do
      it "returns false" do
        expect(game_controller.valid_move?("e2", "e6")).to be false
      end
    end

    context "when black wants to move pawn from e2 to e4" do
      before do
        game_controller.switch_turn
      end

      it "returns false" do
        expect(game_controller.valid_move?("e2", "e4")).to be false
      end
    end
  end

  describe "#export" do
    before do
      allow(game_board).to receive(:move_piece)
    end

    context "when at starting position" do
      before do
        allow(game_board).to receive_messages(en_passant_square: "-",
                                              export: "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR")
      end

      it "returns the correct notation" do
        answer = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
        expect(game_controller.export).to eq(answer)
      end
    end

    context "when white makes the move 1.e4" do
      subject(:game_controller) do
        described_class.import("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      end

      before do
        game_controller.instance_variable_get(:@game_board).populate_possible_moves("e2")
        game_controller.move_piece("e2", "e4")
        game_controller.switch_turn
      end

      it "returns the correct notation" do
        answer = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq e3 0 1"
        expect(game_controller.export).to eq(answer)
      end
    end
  end

  describe "self.#import" do
    context "when called with a notation of move 1.e4 from starting position" do
      it "changes the current FEN specification to match the provided notation" do
        answer = "rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1"
        test_game = described_class.import(answer)
        expect(test_game.export).to eq(answer)
      end
    end
  end

  describe "#move_piece" do
    context "when white makes the move 1.e4" do
      subject(:game_controller) do
        described_class.import("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1")
      end

      it "does not increase the full move counter" do
        game_controller.move_piece("e2", "e4")
        expect(game_controller.instance_variable_get(:@full_moves)).to eq(1)
      end

      it "does not increase the half move counter" do
        game_controller.move_piece("e2", "e4")
        expect(game_controller.instance_variable_get(:@half_moves)).to eq(0)
      end
    end

    context "when black makes the move 1...c5" do
      subject(:game_controller) do
        described_class.import("rnbqkbnr/pppppppp/8/8/4P3/8/PPPP1PPP/RNBQKBNR b KQkq - 0 1")
      end

      before do
        game_controller.move_piece("c7", "c5")
      end

      it "increases the full move counter" do
        expect(game_controller.instance_variable_get(:@full_moves)).to eq(2)
      end

      it "does not increase the half move counter" do
        expect(game_controller.instance_variable_get(:@half_moves)).to eq(0)
      end
    end

    context "when white makes the move 2.Nf3" do
      subject(:game_controller) do
        described_class.import("rnbqkbnr/pp1ppppp/8/2p5/4P3/8/PPPP1PPP/RNBQKBNR w KQkq c6 0 2")
      end

      it "increases the half move counter" do
        game_controller.move_piece("g1", "f3")
        expect(game_controller.instance_variable_get(:@half_moves)).to eq(1)
      end
    end
  end
end
