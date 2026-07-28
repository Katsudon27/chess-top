require_relative "square"
require_relative "conversion"
require_relative "pieces/pawn"
require_relative "pieces/knight"
require_relative "pieces/queen"
require_relative "pieces/rook"
require_relative "pieces/bishop"
require_relative "pieces/king"

# A class that represents the Chess Board in this project
class Board
  include Conversion
  attr_accessor :board

  WHITE_PIECES = { king: "\u2654", queen: "\u2655", rook: "\u2656", bishop: "\u2657", knight: "\u2658",
                   pawn: "\u2659" }.freeze
  BLACK_PIECES = { king: "\u265A", queen: "\u265B", rook: "\u265C", bishop: "\u265D", knight: "\u265E",
                   pawn: "\u265F" }.freeze

  def initialize
    @board = []
    setup_board
    setup_pieces(0, 1, BLACK_PIECES)
    setup_pieces(7, 6, WHITE_PIECES)
  end

  def display
    @board.each_with_index do |row, row_idx|
      puts "#{column_mapping[7 - row_idx]} #{row.map(&:symbol).join('')}"
    end
    puts "   1  2  3  4  5  6  7  8"
  end

  private

  def setup_board
    7.downto(0) do |row_idx|
      row = []
      8.times do |col_idx|
        row << if (row_idx + col_idx).even?
                 Square.new("green", col_idx, row_idx)
               else
                 Square.new("white", col_idx, row_idx)
               end
      end
      @board << row
    end
  end

  def setup_pieces(start_row, pawn_row, pieces)
    @board[pawn_row].each { |square| square.add_piece(Pawn.new(pieces[:pawn])) }
    @board[start_row][0].add_piece(Rook.new(pieces[:rook]))
    @board[start_row][1].add_piece(Knight.new(pieces[:knight]))
    @board[start_row][2].add_piece(Bishop.new(pieces[:bishop]))
    @board[start_row][3].add_piece(Queen.new(pieces[:queen]))
    @board[start_row][4].add_piece(King.new(pieces[:king]))
    @board[start_row][5].add_piece(Bishop.new(pieces[:bishop]))
    @board[start_row][6].add_piece(Knight.new(pieces[:knight]))
    @board[start_row][7].add_piece(Rook.new(pieces[:rook]))
  end
end
