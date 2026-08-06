require_relative "piece"

# A class to represent the Pawn piece on a chess board
class Pawn < Piece
  def initialize(color)
    super(color)
    @symbol = "\u265F"
    @movement_offsets = [[0, 1]]
    @attacking_offsets = [[1, 1], [-1, 1]]
    @max_distance = 2
    @moved = false
    @letter = "p"
  end

  def possible_moves(current_position, board)
    results = super(current_position, board)

    return results if @movement_offsets.length > 3

    current_coordinates = convert_notation(current_position)

    temp_results = results
    temp_results.each do |result|
      target_square = board.find_square(result)
      results.delete(result) unless target_square.empty?
    end

    attacking_movements(current_coordinates, results, board)
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

  private

  def attacking_movements(current_coordinates, results, board)
    @attacking_offsets.each do |attacking_offset|
      movement = Coordinates.new(attacking_offset[0], attacking_offset[1])
      temp = current_coordinates

      move = temp + movement
      next unless move.valid?

      square = board.find_square(move.to_s)
      next if square.empty?

      results << move.to_s if square.piece.color != @color
    end
    results
  end
end
