require_relative "piece"

# A class to represent the Knight piece on a chess board
class Knight < Piece
  def initialize(symbol)
    super(symbol)
    @move_constants = [[1, 2], [-1, 2], [1, -2], [-1, -2], [2, 1], [-2, 1], [2, -1], [2, -2]]
  end
end
