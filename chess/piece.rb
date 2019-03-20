require "singleton"
require "colorize"

module Slideable
  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    potential_moves = []
    move_dirs.each do |dir|
      potential_moves += grow_unblocked_moves_in_dir(dir[0], dir[1])
    end
     
    valid_moves = potential_moves.select do |move|
      if board.valid_pos?(move) 
        if board[move] == NullPiece.instance
          true
        elsif board[move].color != color
          true
        else
          false
        end
      end
    end

    valid_moves
  end

  private
  HORIZONTAL_DIRS = [[-1,0], [0,-1], [1,0], [0,1]]
  DIAGONAL_DIRS = [[1, 1], [-1, 1], [-1, -1], [1, -1]]

  def move_dirs
   
  end

  def grow_unblocked_moves_in_dir(dx,dy)
    unblocked_moves = []
    new_pos = [pos[0] + dx, pos[1] + dy]
    stop = false
    until !board.valid_pos?(new_pos) || stop
      if board[new_pos] != NullPiece.instance && board[new_pos].color != color
        unblocked_moves << new_pos
        new_pos = [new_pos[0] + dx, new_pos[1] + dy]
        stop = true
      elsif board[new_pos] != NullPiece.instance && board[new_pos].color == color
        stop = true
      else
        unblocked_moves << new_pos
        new_pos = [new_pos[0] + dx, new_pos[1] + dy]
      end
    end
    unblocked_moves
  end
end

module Stepable
  def moves
    potential_moves = move_diffs.map do |dir|
      [pos[0] + dir[0], pos[1] + dir[1]]
    end
    valid_moves = potential_moves.select do |move|
      if board.valid_pos?(move) 
        if board[move] == NullPiece.instance
          true
        elsif board[move].color != color
          true
        else
          false
        end
      end
    end

    valid_moves
  end

  private
  def move_diffs
  end
end

class Piece
  attr_reader :color, :board, :pos
  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def to_s
    symbol
  end

  def empty?
  end

  def valid_moves
  end

  def pos=(val)
  end

  def move_into_check?(end_pos)
    dupped_board = board.dup  
    dupped_board.move_piece(color, pos, end_pos)
    dupped_board.in_check?(color)
    
  end

end

class NullPiece < Piece
  include Singleton

  def initialize
  end

  def to_s
    "   "
  end

  def moves 
  end

  def symbol
    " "
  end
end

class Queen < Piece
  include Slideable
  
  def symbol
    case color
    when :white
      " ♛ ".colorize(:white)
    when :black
      " ♛ ".colorize(:black)
    end
  end

  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end

class Rook < Piece
  include Slideable

  def symbol
    case color
    when :white
      " ♜ ".colorize(:white)
    when :black
      " ♜ ".colorize(:black)
    end
  end

  def move_dirs
    horizontal_dirs 
  end
end

class Bishop < Piece
  include Slideable

  def symbol
    case color
    when :white
      " ♝ ".colorize(:white)
    when :black
      " ♝ ".colorize(:black)
    end
  end

  def move_dirs
    diagonal_dirs
  end
end

class King < Piece
  include Stepable

  def symbol
    case color
    when :white
      " ♚ ".colorize(:white)
    when :black
      " ♚ ".colorize(:black)
    end
  end

  def move_diffs
    [[-1,0], [0,-1], [1,0], [0,1], [1, 1], [-1, 1], [-1, -1], [1, -1]]
  end
end

class Knight < Piece
  include Stepable

  def symbol
    case color
    when :white
      " ♞ ".colorize(:white)
    when :black
      " ♞ ".colorize(:black)
    end
  end

  def move_diffs
    [[-2,-1], [-2,1], [-1,-2], [-1,2], [1,-2], [1,2], [2, -1], [2, 1]]
  end

end

class Pawn < Piece
  def symbol
    case color
    when :white
      " ♟ ".colorize(:white)
    when :black
      " ♟ ".colorize(:black)
    end
  end

  def moves
    forward_steps + side_attacks
  end

  private
  def at_start_row?
    if color == :white && pos[0] == 6
      true
    elsif color == :black && pos[0] == 1
      true
    else
      false
    end
  end

  def forward_dir
    case color
    when :white
      -1
    when :black
      1
    end
  end

  def forward_steps
    move_range = 1
    move_range = 2 if at_start_row?
    valid_moves = []
    step = [pos[0] + forward_dir, pos[1]]
    until move_range == 0
      if board.valid_pos?(step) && board[step] == NullPiece.instance
        valid_moves << step
        step = [step[0] + forward_dir, step[1]]
      else
        move_range = 1
      end
      move_range -= 1
    end
    valid_moves
  end

  def side_attacks
    pos[0] + forward_dir 
    left = [pos[0] + forward_dir, pos[1] - 1]
    right = [pos[0] + forward_dir, pos[1] + 1]
    valid_attacks = []
    valid_attacks << left if board.valid_pos?(left) && board[left] != NullPiece.instance && board[left].color != color
    valid_attacks << right if board.valid_pos?(right) && board[right] != NullPiece.instance && board[right].color != color
    valid_attacks
  end

end

