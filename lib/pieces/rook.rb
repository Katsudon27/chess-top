require_relative "piece"

# A class to represent the Rook piece on a chess board
class Rook < Piece
  def initialize(symbol, color)
    super(symbol, color)
    @movement_offsets = [[1, 0], [-1, 0], [0, 1], [0, -1]]
    @letter = "r"
  end
end
