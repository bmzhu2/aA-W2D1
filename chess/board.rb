require_relative "piece.rb"

class Board
  attr_reader :rows
  def initialize
    @rows = Array.new(8) {Array.new(8)}
    @sentinel = NullPiece.instance
    
    rows.each_with_index do |row, idx|
      if idx == 0
        (0...8).each_with_index do |piece, col|
          if col == 0 || col == 7
            rows[idx][col] = Rook.new(:black, self, [idx, col])
          elsif col == 1 || col == 6
            rows[idx][col] = Knight.new(:black, self, [idx, col])
          elsif col == 2 || col == 5
            rows[idx][col] = Bishop.new(:black, self, [idx, col])
          elsif col == 3
            rows[idx][col] = Queen.new(:black, self, [idx, col])
          else
            rows[idx][col] = King.new(:black, self, [idx, col])
          end
        end
      elsif idx == 1
        (0...8).each { |col| rows[idx][col] = Pawn.new(:black, self, [idx, col]) } 
      elsif idx == 6
        (0...8).each { |col| rows[idx][col] = Pawn.new(:white, self, [idx, col]) } 
      elsif idx == 7
        (0...8).each_with_index do |piece, col|
          if col == 0 || col == 7
            rows[idx][col] = Rook.new(:white, self, [idx, col])
          elsif col == 1 || col == 6
            rows[idx][col] = Knight.new(:white, self, [idx, col])
          elsif col == 2 || col == 5
            rows[idx][col] = Bishop.new(:white, self, [idx, col])
          elsif col == 3
            rows[idx][col] = Queen.new(:white, self, [idx, col])
          else
            rows[idx][col] = King.new(:white, self, [idx, col])
          end
        end
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

    raise InvalidMoveError if !piece.moves.include?(end_pos)

    self[end_pos] = piece
    self[start_pos] = sentinel
  end

  def valid_pos?(pos)
    bounds = (0...8).to_a
    bounds.include?(pos[0]) && bounds.include?(pos[1])
  end

  def add_piece(piece, pos)
  end

  def checkmate?(color)
    return false if !in_check?(color)
    ally_pieces = pieces.select do |piece|
      self[piece].color == color  
    end
  end

  def in_check?(color)
    king_pos = find_king(color)
    enemy_pieces = pieces.select do |piece|
      self[piece].color != color  
    end
    enemy_pieces.each do |enemy|
      p enemy
      p self[enemy]
      return true if self[enemy].moves.include?(king_pos)
    end
    false
  end

  def find_king(color)
    pieces.each do |piece|
      return piece if self[piece].is_a?(King) && color == self[piece].color 
    end
  end

  def pieces
    pieces_arr = []
    rows.each do |row|
      row.each do |tile|
        pieces_arr << tile.pos if tile != sentinel
      end 
    end
    pieces_arr
  end

  def dup
    dup_board = Board.new
    rows.each_with_index do |row, idx|
      row.each_with_index do |tile, col|
        pos = [idx, col]
        if tile.is_a?(King)
          dup_board[pos] = King.new(tile.color, dup_board, pos)
        elsif tile.is_a?(Queen)
          dup_board[pos] = Queen.new(tile.color, dup_board, pos)
        elsif tile.is_a?(Rook)
          dup_board[pos] = Rook.new(tile.color, dup_board, pos)
        elsif tile.is_a?(Bishop)
          dup_board[pos] = Bishop.new(tile.color, dup_board, pos)
        elsif tile.is_a?(Knight)
          dup_board[pos] = Knight.new(tile.color, dup_board, pos)
        elsif tile.is_a?(Pawn)
          dup_board[pos] = Pawn.new(tile.color, dup_board, pos)
        else 
          dup_board[pos] = sentinel
        end
      end
    end
    dup_board
    
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