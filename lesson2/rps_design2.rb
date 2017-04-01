
class Move
  attr_accessor :value
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def self.appropriate(choice)
    case choice
    when 'rock' then Rock.new
    when 'paper' then Paper.new
    when 'scissors' then Scissors.new
    when 'lizard' then Lizard.new
    when 'spock' then Spock.new
    end
  end
end

class Rock < Move
  def initialize
    super('rock')
  end

  def enemies
    @enemies = ['paper', 'spock']
  end

  def targets
    @targets = ['lizard', 'scissors']
  end

  def greater_than?(other_move)
    targets.include?(other_move.value)
  end

  def weaker_than?(other_move)
    enemies.include?(other_move.value)
  end
end

class Paper < Move
  def initialize
    super('paper')
  end

  def enemies
    @enemies = ['scissors', 'lizard']
  end

  def targets
    @targets = ['rock', 'spock']
  end

  def greater_than?(other_move)
    targets.include?(other_move.value)
  end

  def weaker_than?(other_move)
    enemies.include?(other_move.value)
  end
end

class Scissors < Move
  def initialize
    super('scissors')
  end

  def enemies
    @enemies = ['rock', 'spock']
  end

  def targets
    @targets = ['lizard', 'paper']
  end

  def greater_than?(other_move)
    targets.include?(other_move.value)
  end

  def weaker_than?(other_move)
    enemies.include?(other_move.value)
  end
end

class Lizard < Move
  def initialize
    super('lizard')
  end

  def enemies
    @enemies = ['rock', 'scissors']
  end

  def targets
    @targets = ['paper', 'spock']
  end

  def greater_than?(other_move)
    targets.include?(other_move.value)
  end

  def weaker_than?(other_move)
    enemies.include?(other_move.value)
  end
end

class Spock < Move
  def initialize
    super('spock')
  end

  def enemies
    @enemies = ['paper', 'rock']
  end

  def targets
    @targets = ['lizard', 'scissors']
  end

  def greater_than?(other_move)
    targets.include?(other_move.value)
  end

  def weaker_than?(other_move)
    enemies.include?(other_move.value)
  end
end

class Player < Move
  attr_accessor :name, :move

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    system 'clear'
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.strip.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n.strip
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock."
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.appropriate(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Federer', 'Zuckerberg', 'Mister_Random',
                 'Nadal', 'Chameleon'].sample
  end

  def choose
    case name
    when 'Chameleon' then self.move = Move.appropriate(Options.chameleon)
    when 'Nadal' then self.move = Move.appropriate(Options.unbeatable)
    when 'Federer' then self.move = Move.appropriate(Options.ruthless)
    when 'Mister_Random' then self.move = Move.appropriate(Options.random)
    when 'Zuckerberg' then self.move = Move.appropriate(Options.smart)
    end
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :human_score, :computer_score, :move_history

  def initialize
    @human = Human.new
    @computer = Computer.new
    @human_score = 0
    @computer_score = 0
    @move_history = { human.name => [], computer.name => [] }
  end

  def info
    @move_history[human.name]
  end

  def display_welcome_message
    system 'clear'
    puts "Welcome to Rock, Paper, Scissors, Lizard and Spock!"
    puts "You're playing against : #{computer.name}."
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard and Spock. Goodbye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move.greater_than?(computer.move)
      @human_score += 1
      puts "#{human.name} won!"
    elsif human.move.weaker_than?(computer.move)
      @computer_score += 1
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_score
    puts "#{human.name} has #{@human_score}."
    puts "#{computer.name} has #{@computer_score}"
  end

  def biggest_percentage(move_history_hash)
    percentages = { 'rock' => 0.0,
                    'paper' => 0.0,
                    'scissors' => 0.0,
                    'lizard' => 0.0,
                    'spock' => 0.0 }
    move_history_hash.each do |move|
      percentages[move] += 1.0
    end
    total = percentages.values.reduce(:+)
    percentages.each do |move, value|
      percentages[move] = (value * 100.0) / total
    end
    percentages.select { |_, value| value == percentages.values.max }
               .to_a.flatten
    # [move, percentage] (ex: ["rock", 71.5])
  end

  def repetitive_move
    biggest_percentage(@move_history[human.name])[0]
  end

  def find_enemy(move)
    move.enemies.sample
  end

  def smart_choice
    return false if computer.name != 'smart'
    human_choices = @move_history[human.name]
    favorite_choice_percentage = biggest_percentage(human_choices)[1]
    if (human_choices.size > 4) && (favorite_choice_percentage >= 66)
      computer.move = find_enemy(repetitive_move)
      return "there is a smart choice"
    end
    false
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end
    system 'clear'
    return true if answer == "y"
    false
  end

  def end_of_game?
    @computer_score >= 5 || @human_score >= 5
  end

  def display_overall_winner
    system 'clear'
    if @computer_score > @human_score
      puts "It looks like #{computer.name} was the luckiest."
    elsif @human_score > @computer_score
      puts "It looks like #{human.name} was the luckiest."
    else
      puts "It looks like it's an overall tie."
    end
  end

  def move_history_format
    puts "Moves history for #{human.name} :"
    @move_history[human.name].each_with_index do |move, idx|
      puts "#{idx + 1}. #{move}"
    end
    puts "\nMoves history for #{computer.name} :"
    @move_history[computer.name].each_with_index do |move, idx|
      puts "#{idx + 1}. #{move}"
    end
  end

  def display_moves_history?
    puts "\n\nWould you like to display the moves history?(y/n)"
    answer = gets.chomp
    loop do
      break if answer == "y" || answer == "n"
      puts "sorry, the input is wrong.(y/n)"
      answer = gets.chomp
    end
    return if answer == "n"
    system 'clear'
    move_history_format
  end

  def final_display
    display_overall_winner
    display_moves_history?
    display_goodbye_message
  end

  def human_choice
    human_info = @move_history[human.name]
    human.choose
    human_info << human.move.value
  end

  def computer_choice
    computer_info = @move_history[computer.name]
    computer.choose
    computer_info << computer.move.value
  end

  def initial_choices
    human_choice
    computer_choice
  end

  def display_info
    system 'clear'
    display_moves
    display_winner
    display_score
  end

  def main_play
    loop do
      initial_choices
      display_info
      break if end_of_game? || !play_again?
    end
  end

  def play
    display_welcome_message
    main_play
    final_display
  end
end

GAME = RPSGame.new

class Options < Computer
  def self.chameleon
    GAME.info[-2] || GAME.info[-1]
  end

  def self.unbeatable
    GAME.info[-1]
  end

  def self.random
    Move::VALUES.sample
  end

  def self.ruthless
    GAME.find_enemy(GAME.info.last)
  end

  def self.smart
    GAME.smart_choice || Move::VALUES.sample
  end
end

GAME.play
