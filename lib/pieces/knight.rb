require_relative "piece"
require_relative "../coordinates"
require_relative "../conversion"

# A class to represent the Knight piece on a chess board
class Knight < Piece
  include Conversion
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
  end

  def possible_moves(current_position)
    results = []
    current_coordinates = convert_notation(current_position)
    @movement_offsets.each do |movement_offset|
      movement = Coordinates.new(movement_offset[0], movement_offset[1])
      move = current_coordinates + movement

      results << move.to_s if move.valid?
    end
    results
  end
end
