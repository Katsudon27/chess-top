require_relative "piece"

# A class to represent the Knight piece on a chess board
class Knight < Piece
  def initialize(color)
    super(color)
    @symbol = "\u265E"
    @movement_offsets = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
    @max_distance = 1
    @letter = "n"
  end
end
