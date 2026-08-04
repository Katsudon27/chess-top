require_relative "coordinates"
require "rainbow"

# A class that is used to represent a square of the chess board
class Square
  attr_reader :piece
  attr_accessor :possible_moves

  def initialize(color, x_coord, y_coord)
    @symbol = "   "
    @color = color
    @coordinates = Coordinates.new(x_coord, y_coord)
    @piece = nil
    @possible_moves = []
    @highlight = false
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

  def remove_highlight
    @highlight = false
  end

  def add_highlight
    @highlight = true
  end

  def symbol
    if empty? && @highlight == false
      Rainbow(@symbol).bg(@color.to_sym)
    elsif empty? && @highlight == true
      Rainbow(@symbol).bg(:yellow)
    elsif @highlight == true
      Rainbow(@symbol).color(@piece.color.to_sym).bg(:yellow)
    else
      Rainbow(@symbol).color(@piece.color.to_sym).bg(@color.to_sym)
    end
  end
end
