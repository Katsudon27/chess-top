require_relative "piece"

# A class to represent the King piece on a chess board
class King < Piece
  def initialize(symbol, color)
    super(symbol, color)
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    @max_distance = 1
  end
end
