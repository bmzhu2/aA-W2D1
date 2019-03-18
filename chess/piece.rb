require "singleton"

class Piece
  attr_reader :color, :board, :pos
  def initialize#(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    "p"
  end

  def empty?
  end

  def valid_moves
    [[3,3]]
  end

  def pos=(val)
  end

  def symbol
  end

  def move_into_check?(end_pos)
  end

end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def moves 
  end

  def symbol
  end
end

