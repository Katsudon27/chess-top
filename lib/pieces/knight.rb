require_relative "piece"

# A class to represent the Knight piece on a chess board
class Knight < Piece
  def initialize(symbol, color)
    super(symbol, color)
    @movement_offsets = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
    @max_distance = 1
  end
end
