require "colorize"
require_relative "cursor.rb"
require_relative "board.rb"

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    board.rows.each { |row| p row }
    board[cursor.cursor_pos].colorize(:blue)
  end

end