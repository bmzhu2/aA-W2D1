require "colorize"
require_relative "cursor.rb"
require_relative "board.rb"
require "byebug"

class Display

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0, 0], board)
  end

  def render
    system("clear")
    cursor_pos = cursor.cursor_pos

    (0...8).each do |row| 
      row_output = ""
      (0...8).each do |col|

        if cursor_pos == [row, col]
          if [row, col] == cursor.selected 
            row_output += board[cursor_pos].to_s.colorize(:background => :magenta)
          else 
            row_output += board[cursor_pos].to_s.colorize(:background => :blue)
          end
        elsif [row, col] == cursor.selected
          row_output += board[cursor_pos].to_s.colorize(:background => :red)
        else 
          if (row.even? && col.even?) || (!row.even? && !col.even?)
            row_output += board[[row, col]].to_s.colorize(:background => :light_cyan)
          else
            row_output += board[[row, col]].to_s.colorize(:background => :light_black)
          end
        end
      end
      puts row_output
    end
  end

  def move_around
    while true
      render
      cursor.get_input
    end
  end
  
end

screen = Display.new(Board.new)
p screen.board.dup