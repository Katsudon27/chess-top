require_relative "piece"

# A class to represent the Pawn piece on a chess board
class Pawn < Piece
  def initialize(symbol, color)
    super(symbol, color)
    @movement_offsets = [[0, 1]]
    @max_distance = 2
    @moved = false
    @letter = "p"
  end

  def already_moved
    @moved = true
    @max_distance = 1
  end

  def promote(replacement)
    case replacement
    when "Q"
      @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1], [1, 0], [-1, 0], [0, 1], [0, -1]]
      @max_distance = 8
    when "N"
      @movement_offsets = [[2, 1], [2, -1], [1, 2], [1, -2], [-2, 1], [-2, -1], [-1, 2], [-1, -2]]
    when "R"
      @movement_offsets = [[1, 0], [-1, 0], [0, 1], [0, -1]]
      @max_distance = 8
    when "B"
      @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
      @max_distance = 8
    end
  end
end
