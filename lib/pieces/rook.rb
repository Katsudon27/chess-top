require_relative "piece"
require_relative "../coordinates"
require_relative "../conversion"

# A class to represent the Rook piece on a chess board
class Rook < Piece
  include Conversion
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end

  def possible_moves(current_position)
    results = []
    current_coordinates = convert_notation(current_position)
    @movement_offsets.each do |movement_offset|
      movement = Coordinates.new(movement_offset[0], movement_offset[1])
      temp = current_coordinates
      loop do
        move = temp + movement
        break unless move.valid?

        results << move.to_s
        temp = move
      end
    end
    results
  end
end
