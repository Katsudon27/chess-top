require_relative "pawn"
require_relative "knight"
require_relative "queen"
require_relative "rook"
require_relative "bishop"
require_relative "king"

class PieceFactory
  TYPES = {
    "r": Rook,
    "q": Queen,
    "b": Bishop,
    "k": King,
    "n": Knight,
    "p": Pawn
  }

  def self.for(letter)
    color = letter == letter.downcase ? "black" : "white"
    TYPES[letter.downcase.to_sym].new(color)
  end
end
