require "singleton"

class Piece
  attr_reader :color, :board, :pos
  def initialize#(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    "P"
  end

  def inspect
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
    :piece
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
    :nullpiece
  end
end

class Queen < Piece
  include Slideable
  
  def symbol
    :queen
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end

class Rook < Piece
  include Slideable

  def symbol
    :rook
  end

  def move_dirs
    horizontal_dirs 
  end
end

class Bishop < Piece
  include Slideable

  def symbol
    :bishop
  end

  def move_dirs
    diagonal_dirs
  end
end

class King < Piece
  include Stepable

  def symbol
    :king
  end

  def move_dirs
  end

end

class Knight < Piece
  include Stepable

  def symbol
    :knight
  end

  def move_dirs
  end

end

class Pawn < Piece
  def symbol
    :pawn
  end

  def move_dirs
  end

  private
  def at_start_row?
  end

  def forward_dir
    #returns 1 or -1
  end

  def forward_steps
  end

  def side_attacks
  end

end

module Slideable
  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    #moves contains array that will have positions that the piece can move
    #checked again valid moves
  end

  private
  HORIZONTAL_DIRS = [[-1,0], [0,-1], [1,0], [0,1]]
  DIAGONAL_DIRS = [[1, 1], [-1, 1], [-1, -1], [1, -1]]

  def move_dirs
  end

  def grow_unblocked_moves_in_dir(dx,dy)
  end


end

module Stepable
  def moves
  end

  private
  def move_diffs
  end
end