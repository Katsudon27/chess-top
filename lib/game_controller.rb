require_relative "board"
require_relative "player"
require_relative "pieces/pawn"
require_relative "pieces/piece"

# A class that controls the flow of the Chess game
class GameController
  attr_reader :current_player

  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @game_board = board
    @current_player = @player1
    @half_moves = 0
    @full_moves = 1
    @first_move = true
  end

  def switch_turn
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def move_piece(start, target)
    @game_board.move_piece(start, target)

    start_square = @game_board.find_square(start)
    target_square = @game_board.find_square(target)

    if start_square.piece.is_a?(Pawn) || !target_square.empty?
      @half_moves = 0
    else
      @half_moves += 1
    end

    @full_moves += 1 if @first_move == false
    @first_move = false if @first_move == true
  end

  def valid_move?(start, target)
    start_square = @game_board.find_square(start)

    if start_square.piece.color == @current_player.color && start_square.possible_moves.include?(target)
      true
    else
      false
    end
  end

  def export
    export_notation = @game_board.export
    export_notation += if @current_player.color == "white"
                         " w"
                       else
                         " b"
                       end

    # TODO: Castling rights
    export_notation += " KQkq"

    # TODO: En passant square
    export_notation += " -"

    export_notation += " #{@half_moves}"
    export_notation + " #{@full_moves}"
  end
end
