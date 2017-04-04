require 'pry'

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

  def greater_than?(other_move)
    targets.include?(other_move.value)
  end

  def weaker_than?(other_move)
    enemies.include?(other_move.value)
  end
end

class Rock < Move
  def initialize
    super('rock')
  end

  def enemies
    ['paper', 'spock']
  end

  def targets
    ['lizard', 'scissors']
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
end

class Spock < Move
  def initialize
    super('spock')
  end

  def enemies
    @enemies = ['paper', 'lizard']
  end

  def targets
    @targets = ['rock', 'scissors']
  end
end

class Player
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

  def choose(any_strategy)
    case name
    when 'Chameleon' then self.move = Move.appropriate(any_strategy.chameleon)
    when 'Nadal' then self.move = Move.appropriate(any_strategy.unbeatable)
    when 'Federer' then self.move = Move.appropriate(any_strategy.ruthless)
    when 'Mister_Random' then self.move = Move.appropriate(any_strategy.random)
    when 'Zuckerberg' then self.move = Move.appropriate(any_strategy.smart)
    end
  end
end

class Strategies
  attr_reader :info

  def initialize(info)
    @info = info
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
    biggest_percentage(info)[0]
  end

  def find_enemy(move)
    if move.nil?
      false
    else
      Move.appropriate(move).enemies.sample
    end
  end

  def smart_choice
    favorite_choice_percentage = biggest_percentage(info)[1]
    if (info.size > 4) && (favorite_choice_percentage >= 50)
      mv = find_enemy(repetitive_move)
      return mv
    end
    false
  end

  def chameleon
    info[-2] || info[-1]
  end

  def unbeatable
    info[-1]
  end

  def random
    Move::VALUES.sample
  end

  def ruthless
    find_enemy(info.last)
  end

  def smart
    smart_choice || find_enemy(info[-2]) || Move::VALUES.sample
  end
end

module Resultable
  def result(first_move, second_move)
    if first_move.greater_than?(second_move)
      :won
    elsif first_move.weaker_than?(second_move)
      :lost
    else
      :tie
    end
  end
end

class History
  include Resultable
  attr_accessor :info, :human, :computer

  def initialize(player, opponent)
    @info = { player.name => [], opponent.name => [] }
    @human_info = @info[player.name]
    @comp_info = @info[opponent.name]
    @human = player
    @computer = opponent
  end

  def score_at(move_index)
    score1 = 0
    score2 = 0
    0.upto(move_index) do |idx|
      if result(Move.appropriate(@human_info[idx]),
                Move.appropriate(@comp_info[idx])) == :won
        score1 += 1
      elsif result(Move.appropriate(@human_info[idx]),
                   Move.appropriate(@comp_info[idx])) == :lost
        score2 += 1
      end
      idx += 1
      break if idx >= @human_info.size
    end
    "#{score1}-#{score2}"
  end

  def format_
    idx = 0
    loop do
      puts "\n#{idx + 1}. #{@human_info[idx]}"\
           " (#{result(Move.appropriate(@human_info[idx]),
                       Move.appropriate(@comp_info[idx]))}"\
           " against #{@comp_info[idx]})"
      puts "   #{score_at(idx)}"
      idx += 1
      break if idx >= @human_info.size
    end
  end

  def display
    system 'clear'
    puts "Moves history for #{human.name} :"
    format_
  end

  def player_update(move)
    @human_info << move
  end

  def opponent_update(move)
    @comp_info << move
  end
end

# Game Orchestration Engine
class RPSGame
  include Resultable
  attr_accessor :human, :computer, :strategy, :move_history

  def initialize
    @human = Human.new
    @computer = Computer.new
    @human_score = 0
    @computer_score = 0
    @move_history = History.new(@human, @computer)
    @strategy = Strategies.new(@move_history.info[human.name])
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

  def update_score
    @human_score += 1 if human_won
    @computer_score += 1 if computer_won
  end

  def human_won
    result(human.move, computer.move) == :won
  end

  def computer_won
    result(human.move, computer.move) == :lost
  end

  def tie
    result(human.move, computer.move) == :tie
  end

  def display_winner
    puts "It's a tie" if tie
    puts "#{human.name} won!" if human_won
    puts "#{computer.name} won!" if computer_won
  end

  def display_score
    puts "#{human.name} has #{@human_score}."
    puts "#{computer.name} has #{@computer_score}."
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
    answer == 'y'
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

  def display_move_history?
    puts "\n\nWould you like to display the moves history?(y/n)"
    answer = gets.chomp
    loop do
      break if answer == "y" || answer == "n"
      puts "sorry, the input is wrong.(y/n)"
      answer = gets.chomp
    end
    answer == 'y'
  end

  def final_display
    display_overall_winner
    move_history.display if display_move_history?
    display_goodbye_message
  end

  def human_choice
    human.choose
    move_history.player_update(human.move.value)
  end

  def computer_choice
    computer.choose(strategy)
    move_history.opponent_update(computer.move.value)
  end

  def initial_choices
    human_choice
    computer_choice
  end

  def display_info
    system 'clear'
    display_moves
    update_score
    display_winner
    display_score
  end

  def main_play
    loop do
      initial_choices
      display_info
      break if !play_again?
    end
  end

  def play
    display_welcome_message
    main_play
    final_display
  end
end

game = RPSGame.new
game.play
