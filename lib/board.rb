require_relative "square"
require_relative "conversion"
require_relative "pieces/piece_factory"

# A class that represents the Chess Board in this project
class Board
  include Conversion
  attr_accessor :en_passant_square

  def initialize(board = [], import: false)
    @board = board
    @en_passant_square = "-"
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
    start_square = find_square(start)
    target_square = find_square(target)

    en_passant(start_square, target_square)

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
    square = find_square(position)
    square.possible_moves = square.piece.possible_moves(position, self)
    highlight_squares(square.possible_moves)
  end

  def find_square(notation)
    coordinates = convert_notation(notation)
    @board[7 - coordinates.y_coord][coordinates.x_coord]
  end

  private

  def clear
    @board.each do |row|
      row.each { |square| square.clear unless square.empty? }
    end
  end

  def highlight_squares(notations)
    notations.each do |notation|
      square = find_square(notation)
      square.add_highlight
    end
  end

  def en_passant(start_square, target_square)
    if start_square.piece.is_a?(Pawn)
      if target_square.coordinates.to_s == @en_passant_square
        offset = en_passant_offset(start_square)
        find_square((target_square.coordinates + offset).to_s).clear
        @en_passant_square = "-"
      elsif (target_square.coordinates - start_square.coordinates).y_coord.even?
        @en_passant_square = start_square.possible_moves[0]
      else
        @en_passant_square = "-"
      end
    elsif @en_passant_square != "-" && target_square.coordinates.to_s != @en_passant_square
      @en_passant_square = "-"
    end
  end
end
