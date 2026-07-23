require_relative "piece"
require_relative "../coordinates"
require_relative "../conversion"

# A class to represent the Bishop piece on a chess board
class Bishop < Piece
  include Conversion
  def initialize(symbol)
    super(symbol)
    @movement_offsets = [[1, 1], [-1, 1], [1, -1], [-1, -1]]
  end
end
