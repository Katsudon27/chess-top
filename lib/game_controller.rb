require_relative "board"
require_relative "player"
require_relative "conversion"

# A class that controls the flow of the Chess game
class GameController
  include Conversion
  attr_reader :current_player

  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @game_board = board
    @current_player = @player1
    @half_moves = 0
    @full_moves = 0
  end

  def switch_turn
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def move_piece(start, target)
    @game_board.move_piece(start, target)
  end

  def valid_move?(start, target)
    start_square = @game_board.find_square(convert_notation(start))

    if start_square.piece.color == @current_player.color && start_square.possible_moves.include?(target)
      true
    else
      false
    end
  end
end
