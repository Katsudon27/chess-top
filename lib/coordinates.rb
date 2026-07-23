require_relative "conversion"

# A class used to represent the coordinates of a square on the chess board
class Coordinates
  include Conversion
  attr_reader :x_coord, :y_coord

  def initialize(x_coord, y_coord)
    @x_coord = x_coord
    @y_coord = y_coord
  end

  def to_s
    column_mapping[x_coord] + (y_coord + 1).to_s
  end

  def +(other)
    Coordinates.new(@x_coord + other.x_coord, @y_coord + other.y_coord)
  end

  def valid?
    @x_coord.between?(0, 7) && @y_coord.between?(0, 7)
  end
end
