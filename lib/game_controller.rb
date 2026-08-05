require_relative "board"
require_relative "player"
require_relative "pieces/pawn"
require_relative "pieces/piece"

# A class that controls the flow of the Chess game
class GameController
  attr_reader :current_player

  def initialize(white_player, black_player, board, current_player = "w", moves = [0, 1])
    @player1 = white_player
    @player2 = black_player
    @game_board = board

    @current_player = if current_player == "w"
                        @player1
                      else
                        @player2
                      end

    @half_moves = moves[0]
    @full_moves = moves[1]
    @first_move = @full_moves == 1
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

  def self.import(import_notation)
    notation_array = import_notation.split(" ")
    board = Board.import(notation_array[0])
    current_player = notation_array[1]
    white_castling_rights = ""
    black_castling_rights = ""

    if notation_array[2] != "-"
      white_castling_rights += "K" if notation_array.include?("K")
      white_castling_rights += "Q" if notation_array.include?("Q")
      black_castling_rights += "k" if notation_array.include?("k")
      black_castling_rights += "q" if notation_array.include?("q")
    end

    player1 = Player.new("White", "white", white_castling_rights)
    player2 = Player.new("Black", "black", black_castling_rights)

    # TODO: En passant square for notation_array[3]

    moves = [notation_array[4], notation_array[5]]
    new(player1, player2, board, current_player, moves)
  end
end
