# A class that represents the player for the Chess game
class Player
  attr_reader :name, :symbol

  def initialize(name, pieces)
    @name = name
    @pieces = pieces
  end
end
