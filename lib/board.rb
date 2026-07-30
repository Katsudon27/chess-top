require_relative "square"
require_relative "conversion"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/queen"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/king"
require_relative "pieces/piece_factory"

# A class that represents the Chess Board in this project
class Board
  include Conversion
  attr_accessor :board

  def initialize
    @board = []
    setup_board
    setup_pieces(0, 1, "black")
    setup_pieces(7, 6, "white")
  end

  def display
    @board.each_with_index do |row, row_idx|
      puts "#{column_mapping[7 - row_idx]} #{row.map(&:symbol).join('')}"
    end
    puts "   1  2  3  4  5  6  7  8"
  end

  def export
    notation = []
    @board.each do |row|
      row_notation = ""
      empty_squares = 0
      row.each do |square|
        if square.empty?
          empty_squares += 1
        else
          row_notation += empty_squares.to_s unless empty_squares.zero?
          row_notation += square.piece.notation
          empty_squares = 0
        end
      end
      row_notation += empty_squares.to_s unless empty_squares.zero?
      notation << row_notation
    end
    notation.join("/")
  end

  def move_piece(start, target)
    start_square = find_square(convert_notation(start))
    target_square = find_square(convert_notation(target))
    target_square.add_piece(start_square.piece)
    start_square.clear
  end

  def import(notation)
    clear
    notation.split("/").each_with_index do |row, row_idx|
      target_row = @board[row_idx]
      square_idx = 0
      row.split("").each do |placement|
        unless numeric?(placement)
          target_row[square_idx].add_piece(PieceFactory.for(placement))
          square_idx += 1
        end
        placement.to_i.times { square_idx += 1 }
      end
    end
  end

  private

  def setup_board
    7.downto(0) do |row_idx|
      row = []
      8.times do |col_idx|
        row << if (row_idx + col_idx).even?
                 Square.new("darkslategray", col_idx, row_idx)
               else
                 Square.new("webgray", col_idx, row_idx)
               end
      end
      @board << row
    end
  end

  def find_square(coordinates)
    @board[7 - coordinates.y_coord][coordinates.x_coord]
  end

  def setup_pieces(start_row, pawn_row, color)
    @board[pawn_row].each { |square| square.add_piece(Pawn.new(color)) }
    @board[start_row][0].add_piece(Rook.new(color))
    @board[start_row][1].add_piece(Knight.new(color))
    @board[start_row][2].add_piece(Bishop.new(color))
    @board[start_row][3].add_piece(Queen.new(color))
    @board[start_row][4].add_piece(King.new(color))
    @board[start_row][5].add_piece(Bishop.new(color))
    @board[start_row][6].add_piece(Knight.new(color))
    @board[start_row][7].add_piece(Rook.new(color))
  end

  def clear
    @board.each do |row|
      row.each { |square| square.clear unless square.empty? }
    end
  end
end
