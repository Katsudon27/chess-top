require_relative "../lib/game_controller"
require_relative "../lib/board"
require_relative "../lib/player"
require_relative "../lib/square"
require_relative "../lib/pieces/pawn"

describe GameController do
  subject(:game_controller) { described_class.new(first_player, second_player, game_board) }

  let(:first_player) { instance_double(Player) }
  let(:second_player) { instance_double(Player) }
  let(:game_board) { instance_double(Board) }
  let(:square) { instance_double(Square) }
  let(:pawn) { instance_double(Pawn) }

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
      allow(game_board).to receive(:find_square).and_return(square)
      allow(square).to receive_messages(possible_moves: %w[e3 e4], piece: pawn)
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
end
