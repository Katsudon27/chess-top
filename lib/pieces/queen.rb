require_relative "piece"

# A class to represent the Queen piece on a chess board
class Queen < Piece
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
