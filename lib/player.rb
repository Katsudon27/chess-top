# A class that represents the player for the Chess game
class Player
  attr_reader :name, :color

  def initialize(name, color, castling_rights = "")
    @name = name
    @color = color
    unless castling_rights.empty?
      castling_rights.downcase.split("").each do |castling_right|
        @kingside_castle = castling_right == "k"
        @queenside_castle = castling_right == "q"
      end
    end

    @kingside_castle = false
    @queenside_castle = false
  end

  def choose_piece
    puts "#{@name}'s turn: Please choose a piece to be moved by providing the square currently being occupied by it."
    gets.chomp.to_s
  end

  def choose_square
    puts "#{@name}'s turn: Please choose a square to place the chosen piece."
    gets.chomp.to_s
  end
end
