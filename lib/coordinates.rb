# A class used to represent the coordinates of a square on the chess board
class Coordinates
  attr_reader :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end

  def to_s
    column_mapping[@column] + @row.to_s
  end

  def +(other)
    Coordinates.new(@row + other.row, @column + other.column)
  end

  private

  def column_mapping
    columns = ("a".."h").to_a
    hash = {}
    (0..7).each { |num| hash[num] = columns[num] }
    hash
  end
end
