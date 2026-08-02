require_relative "board"
require_relative "player"

# A class that controls the flow of the Chess game
class GameController
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
end
