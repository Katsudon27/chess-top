require_relative "piece"

# A class to represent the Rook piece on a chess board
class Rook < Piece
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
