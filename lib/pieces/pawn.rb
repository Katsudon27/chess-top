require_relative "piece"

# A class to represent the Pawn piece on a chess board
class Pawn < Piece
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[0, 1]]
    @max_distance = 2
    @moved = false
  end

  def already_moved
    @moved = true
    @max_distance = 1
  end
end
