require_relative "coordinates"
require "colorize"

# A class that is used to represent a square of the chess board
class Square
  attr_reader :piece

  def initialize(color, x_coord, y_coord)
    @symbol = "   "
    @color = color
    @coordinates = Coordinates.new(x_coord, y_coord)
    @piece = nil
    @possible_moves = []
  end

  def add_piece(piece)
    @piece = piece
    @symbol = " #{piece.symbol} "
  end

  def empty?
    @piece.nil?
  end

  def clear
    @piece = nil
    @symbol = "   "
    @possible_moves = []
  end

  def symbol
    @symbol.colorize(background: @color.to_sym)
  end
end
