require_relative "piece"

# A class to represent the Bishop piece on a chess board
class Bishop < Piece
  def initialize(color)
    super(color)
    @symbol = "\u265D"
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
    @letter = "b"
  end
end
