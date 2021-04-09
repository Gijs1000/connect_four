class Board
  attr_reader :board

  def initialize(height = 6, width = 7)
    @height = height
    @width = width
    # build_board(@height, @width)
  end

  def build_board(height, width)
    @board = []
    width.times do |i|
      @board << []
      height.times do
        @board[i] << []
      end
    end
  end

  def update_board(column, symbol)
    column -= 1
    @board[column].unshift(symbol).pop
  end
end
