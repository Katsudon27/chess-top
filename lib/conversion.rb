require_relative "coordinates"

module Conversion
  def column_mapping
    columns = ("a".."h").to_a
    hash = {}
    (0..7).each { |num| hash[num] = columns[num] }
    hash
  end

  def convert_notation(notation)
    coordinate_values = notation.split("")
    Coordinates.new(column_mapping.key(coordinate_values[0]), notation[1].to_i - 1)
  end

  def numeric?(string)
    true if Float(string)
  rescue StandardError
    false
  end
end
