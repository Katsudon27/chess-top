# A class that represents the player for the Chess game
class Player
  attr_reader :name, :symbol

  def initialize(name, pieces)
    @name = name
    @pieces = pieces
  end

  def choose_piece
    puts "#{@name}'s turn: Please choose a piece to be moved."
    gets.chomp.to_s
  end
end
