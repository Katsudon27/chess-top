require_relative "piece"
require_relative "../coordinates"
require_relative "../conversion"

# A class to represent the Rook piece on a chess board
class Rook < Piece
  include Conversion
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end
end
