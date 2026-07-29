require_relative "piece"

# A class to represent the Bishop piece on a chess board
class Bishop < Piece
  def initialize(symbol, color)
    super(symbol, color)
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
  end
end
