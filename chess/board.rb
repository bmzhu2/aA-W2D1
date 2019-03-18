require_relative "piece.rb"

class Board
  attr_reader :rows
  def initialize
    @rows = Array.new(8) {Array.new(8)}
    @sentinel = NullPiece.instance
    
    rows.each_with_index do |row, idx|
      if [0, 1, 6, 7].include?(idx)
        (0...8).each { |col| rows[idx][col] = Piece.new } 
      else
        (0...8).each { |col| rows[idx][col] = sentinel } 
      end
    end
  end

  def [](pos)
    rows[pos[0]][pos[1]]
  end

  def []=(pos,val)
    rows[pos[0]][pos[1]] = val
  end

  def move_piece(color, start_pos, end_pos)
    raise NoPieceError if self[start_pos] == sentinel

    piece = self[start_pos]

    raise InvalidMoveError if !piece.valid_moves.include?(end_pos)

    self[end_pos] = piece
    self[start_pos] = sentinel
  end

  def valid_pos?(pos)
  end

  def add_piece(piece, pos)
  end

  def checkmate?(color)
  end

  def in_check?(color)
  end

  def find_king(color)
  end

  def pieces
  end

  def dup
  end

  def move_piece!(color, start_pos, end_pos)
  end
  private
  attr_reader :sentinel
end

class NoPieceError < StandardError
end

class InvalidMoveError < StandardError
end