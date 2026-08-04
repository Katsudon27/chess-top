require_relative "square"
require_relative "conversion"
require_relative "pieces/piece_factory"

# A class that represents the Chess Board in this project
class Board
  include Conversion
  attr_accessor :board

  def initialize(board = [], import: false)
    @board = board
    return unless import == false

    setup_pieces(0, 1)
    setup_pieces(7, 6, "w")
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

  def self.import(notation)
    board = setup_board
    notation.split("/").each_with_index do |row, row_idx|
      target_row = board[row_idx]
      square_idx = 0
      row.split("").each do |placement|
        if placement.to_i.zero?
          target_row[square_idx].add_piece(PieceFactory.for(placement))
          square_idx += 1
        end
        placement.to_i.times { square_idx += 1 }
      end
    end
    new(board, import: true)
  end

  def self.setup_board
    board = []
    7.downto(0) do |row_idx|
      row = []
      8.times do |col_idx|
        row << if (row_idx + col_idx).even?
                 Square.new("darkslategray", col_idx, row_idx)
               else
                 Square.new("webgray", col_idx, row_idx)
               end
      end
      board << row
    end
    board
  end

  def populate_possible_moves(position)
    square = find_square(convert_notation(position))
    square.possible_moves = square.piece.possible_moves(position, self)
    highlight_squares(square.possible_moves)
  end

  def find_square(coordinates)
    @board[7 - coordinates.y_coord][coordinates.x_coord]
  end

  private

  def setup_pieces(start_row, pawn_row, color = "b")
    pieces = %w[p r n b q k]
    pieces = pieces.map(&:upcase) if color == "w"
    @board[pawn_row].each { |square| square.add_piece(PieceFactory.for(pieces[0])) }
    [0, 7].each { |idx| @board[start_row][idx].add_piece(PieceFactory.for(pieces[1])) }
    [1, 6].each { |idx| @board[start_row][idx].add_piece(PieceFactory.for(pieces[2])) }
    [2, 5].each { |idx| @board[start_row][idx].add_piece(PieceFactory.for(pieces[3])) }
    @board[start_row][3].add_piece(PieceFactory.for(pieces[4]))
    @board[start_row][4].add_piece(PieceFactory.for(pieces[5]))
  end

  def clear
    @board.each do |row|
      row.each { |square| square.clear unless square.empty? }
    end
  end

  def highlight_squares(notations)
    notations.each do |notation|
      square = find_square(convert_notation(notation))
      puts square
      square.add_highlight
    end
  end
end
