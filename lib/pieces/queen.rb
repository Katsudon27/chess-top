require_relative "piece"

# A class to represent the Queen piece on a chess board
class Queen < Piece
  def initialize(color)
    super(color)
    @symbol = "\u265B"
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
    @letter = "q"
  end
end
