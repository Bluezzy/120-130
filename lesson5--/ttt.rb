class Board
  attr_accessor :squares
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :marker, :name
  NAMES = ['Fred', 'Luke', 'Sarah', 'John', 'Anna']

  def initialize(marker, player_type = :human)
    @marker = marker
    @name = NAMES.sample if player_type == :computer
  end
end

class TTTGame
  X_MARKER = "X"
  O_MARKER = "O"
  GAME_CHOICES = ['y', 'yes', 'n', 'no']

  attr_reader :board, :human, :computer, :strategy

  def initialize
    @board = Board.new
    @human = Player.new(X_MARKER)
    @computer = Player.new(O_MARKER, :computer)
    @current_marker = X_MARKER
    @human_score = 0
    @computer_score = 0
    @first_to_start = false
    @strategy = Strategy.new(@board, @computer.marker)
  end

  def play
    introduction
    initial_choice

    loop do
      display_board
      main_play
      core_display
      break if game_over? || !play_again?
      reset
      display_play_again_message
      turnover
    end
    display_overall_result
    display_goodbye_message
  end

  private

  def first_to_start?
    @first_to_start
  end

  def main_play
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
  end

  def core_display
    update_score
    display_result
    display_score
  end

  def joinor(array, delimiter = ',', joining_word = 'or')
    if array.size > 1
      "#{array[0..-2].join(delimiter + ' ')} #{joining_word} #{array.last}"
    else
      array.first.to_s
    end
  end

  def display_first_message
    clear
    puts "Welcome to Tic Tac Toe, #{human.name}!"
    puts "You're playing against #{computer.name} today."
  end

  def avoid_same_name
    return unless human.name.downcase == computer.name.downcase
    computer.name += "(computer)"
  end

  def computer_choice_format
    if human.name[0].downcase == computer.name[0].downcase
      return computer.name[0..1].downcase
    end
    computer.name[0].downcase
  end

  def human_choice_format
    human.name[0].downcase
  end

  def valid_choices
    [computer_choice_format, human_choice_format]
  end

  def choose
    choice = nil
    loop do
      choice = gets.chomp.downcase
      break if valid_choices.include?(choice.strip.downcase)
      puts "Wrong input. Please type again."
    end
    choice
  end

  def initial_choice
    avoid_same_name
    puts "\nWho should start to play ? ( '#{human_choice_format}'"\
    " for #{human.name} / '#{computer_choice_format}' for #{computer.name} )."
    choice = choose
    return unless computer_choice_format == choice.strip.downcase
    @current_marker = computer.marker
    @first_to_start = true
  end

  def set_human_name
    puts "What's your name?"
    answer = nil
    loop do
      answer = gets.chomp
      break if !answer.strip.empty?
      puts "Please enter a name."
    end
    human.name = answer.capitalize
  end

  def pick_a_marker
    puts "Pick a marker ('X'/'O')"
    loop do
      choice = gets.chomp.upcase
      if choice == 'O'
        human.marker = O_MARKER
        computer.marker = X_MARKER
        break
      elsif choice == 'X'
        human.marker = X_MARKER
        computer.marker = O_MARKER
        break
      else
        puts "Wrong input('X'/'O')"
      end
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def introduction
    clear
    set_human_name
    pick_a_marker
    display_first_message
  end

  def display_board
    puts "#{human.name} is a #{human.marker}."\
     " #{computer.name} is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    puts "Choose a square: #{joinor(board.unmarked_keys, ', ')}. "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def random_move
    board.unmarked_keys.sample
  end

  def computer_moves
    strategy.any_marker = computer.marker
    square = strategy.smart_choice || random_move
    board[square] = computer.marker
  end

  def current_player_moves
    if @current_marker == human.marker
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def update_score
    case board.winning_marker
    when human.marker then @human_score += 1
    when computer.marker then @computer_score += 1
    end
    false
  end

  def display_result
    clear_screen_and_display_board
    case board.winning_marker
    when human.marker then puts "#{human.name} won!"
    when computer.marker then puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name} has: #{@human_score}. #{computer.name} has: " \
    "#{@computer_score}"
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if GAME_CHOICES.include?(answer.downcase)
      puts "Sorry, must be y or n"
    end
    affirmative = GAME_CHOICES[0..1]
    affirmative.include?(answer.downcase)
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
  end

  def game_over?
    (@computer_score >= 5) || (@human_score >= 5)
  end

  def turnover
    if first_to_start?
      @current_marker = human.marker
      @first_to_start = false
    else
      @current_marker = computer.marker
      @first_to_start = true
    end
  end

  def overall_winner
    if @computer_score > @human_score
      :computer
    elsif @human_score > @computer_score
      :human
    else
      :tie
    end
  end

  def display_overall_result
    clear
    case overall_winner
    when :computer then puts "No one can beat #{computer.name}!"
    when :human then puts "Congratulations! No one can beat #{human.name}."
    else
      puts "You're both equally strong (or equally weak..). It's a tie !"
    end
  end
end

class Strategy
  attr_accessor :any_marker, :brd

  def initialize(brd, any_marker)
    @brd = brd
    @any_marker = any_marker
  end

  def smart_choice
    winning_choice || defensive_choice || center_square_move
  end

  def best_square(marker)
    Board::WINNING_LINES.each do |line|
      board_line = {}
      line.each { |key| board_line[key] = brd.squares[key].marker }
      if board_line.values.count(marker) == 2 &&
         board_line.values.count(Square::INITIAL_MARKER) == 1
        return board_line.key(Square::INITIAL_MARKER)
      end
    end
    false
  end

  def winning_choice
    best_square(any_marker)
  end

  def defensive_choice
    best_square(opposite_marker(any_marker))
  end

  def opposite_marker(marker)
    if marker.casecmp("X").zero?
      'O'
    else
      'X'
    end
  end

  def center_square_move
    5 if brd.unmarked_keys.include?(5)
  end
end

game = TTTGame.new
game.play
