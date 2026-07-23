require_relative "coordinates"

# A class that is used to represent a square of the chess board
class Square
  attr_reader :symbol, :piece

  def initialize(symbol, x_coord, y_coord)
    @symbol = symbol
    @coordinates = Coordinates.new(x_coord, y_coord)
    @piece = nil
    @possible_moves = []
  end

  def add_piece(piece)
    @piece = piece
  end

  def empty?
    @piece.nil?
  end

  def clear
    @piece = nil
    @possible_moves = []
  end
end
