require_relative "piece"

# A class to represent the King piece on a chess board
class King < Piece
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
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
