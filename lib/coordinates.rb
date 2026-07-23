# A class used to represent the coordinates of a square on the chess board
class Coordinates
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

  private

  def column_mapping
    columns = ("a".."h").to_a
    hash = {}
    (0..7).each { |num| hash[num] = columns[num] }
    hash
  end
end
