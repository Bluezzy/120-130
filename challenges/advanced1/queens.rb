class Queens
  EMPTY_SQUARE = "-"
  WHITE_QUEEN = "W"
  BLACK_QUEEN = "B"
  attr_accessor :white, :black

  def initialize(white: [0, 3], black: [7, 3])
    @white = white
    @black = black
    raise ArgumentError, "Queens can't be placed in the same square!" if same?
    @wy, @wx, @by, @bx = white[0], white[1], black[0], black[1]
  end

  def to_s
    board = Array.new(8) { Array.new(8, '_') }
    board[@wy][@wx] = 'W'
    board[@by][@bx] = 'B'
    board.map { |row| row.join(' ') }.join("\n").chomp
  end

  def same?
    white == black
  end

  def attack?
    same_row? || same_column? || same_diagonal?
  end

  private

  def same_row?
    @wy == @by
  end

  def same_column?
    @wx == @bx
  end

  def same_diagonal?
    (@wx - @bx).abs == (@wy - @by).abs
  end
end

queens = Queens.new(white: [7, 2], black: [4, 5])