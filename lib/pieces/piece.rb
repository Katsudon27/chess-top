# A class to represent a piece on a chess board
class Piece
  attr_reader :symbol

  def initialize(symbol)
    @symbol = symbol
  end
end
