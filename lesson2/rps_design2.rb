
class Move
  attr_accessor :value
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end
  
  def greater_than?(other_move)
    case @value
    when 'rock' then (Rock::targets).include?(other_move)
    when 'lizard' then (Lizard::targets).include?(other_move)
    when 'spock' then (Spock::targets).include?(other_move)
    when 'paper' then (Paper::targets).include?(other_move)
    when 'scissors' then (Scissors::targets).include?(other_move)
    end
  end
  
  def weaker_than?(other_move)
    case @value
    when 'rock' then (Rock::enemies).include?(other_move)
    when 'lizard' then (Lizard::enemies).include?(other_move)
    when 'spock' then (Spock::enemies).include?(other_move)
    when 'paper' then (Paper::enemies).include?(other_move)
    when 'scissors' then (Scissors::enemies).include?(other_move)
    end
  end
end

class Rock
  attr_accessor :enemies, :targets

  def self.enemies
    @enemies = ['paper', 'spock'] 
  end
  
  def self.targets
    @targets = ['lizard', 'scissors']
  end
end

class Paper
  attr_accessor :enemies, :targets
  
  def self.enemies
    @enemies = ['scissors', 'lizard'] 
  end
  
  def self.targets
    @targets = ['rock', 'spock']
  end  
end

class Scissors
  attr_accessor :enemies, :targets
  
  def self.enemies
    @enemies = ['rock', 'spock'] 
  end
  
  def self.targets
    @targets = ['lizard', 'paper']
  end  
end

class Lizard
  attr_accessor :enemies, :targets
  
  def self.enemies
    @enemies = ['rock', 'scissors'] 
  end
  
  def self.targets
    @targets = ['lizard', 'spock']
  end  
end

class Spock 
  attr_accessor :enemies, :targets
  
  def self.enemies
    @enemies = ['paper', 'rock'] 
  end
  
  def self.targets
    @targets = ['lizard', 'scissors']
  end  
end

class Player < Move
  attr_accessor :move, :name

  def initialize
    set_name
  end    
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock."
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Chameleon', 'Rock_Solid', 'Mister_Random', 'Unbeatable', 'Smart'].sample
  end
  
  def choose
    case name
    when 'Chameleon' then self.move = Options::chameleon
    when 'Rock_Solid' then self.move = Options::rock_solid
    when 'Unbeatable' then self.move = Options::unbeatable
    else
      self.move = Options::random
    end
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer, :human_score, :computer_score, :moves_history

  def initialize
    @human = Human.new
    @computer = Computer.new
    @human_score = 0
    @computer_score = 0
    @moves_history = { human.name => [], computer.name => [] }
  end
  
  def info
    @moves_history[human.name]
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard and Spock!"
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
      percentages[move] = (value*100.0) / total
    end
    percentages.select { |key, value| value == percentages.values.max }.to_a.flatten
    # [move, percentage] (ex: ["rock", 71.5])
  end
  
  def repetitive_move
    biggest_percentage(@moves_history[human.name])[0]
  end
  
  def find_enemy(move)
    case move
    when 'rock' then Rock::enemies.sample
    when 'scissors' then Scissors::enemies.sample
    when 'paper' then Paper::enemies.sample
    when 'lizard' then Lizard::enemies.sample
    when 'spock' then Spock::enemies.sample
    end
  end

  def smart_choice
    return false if computer.name != 'smart'
    human_choices = @moves_history[human.name]
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

    return true if answer == "y"
    false
  end

  def end_of_game?
    @computer_score >= 5 || @human_score >= 5
  end

  def display_overall_winner
    if @computer_score > @human_score
      puts "It looks like #{computer.name} was the luckiest."
    elsif @human_score > @computer_score
      puts "It looks like #{human.name} was the luckiest."
    else
      puts "It looks like it's an overall tie."
    end
  end
  
  def display_moves_history?
    puts ("\n\n")
    puts "Would you like to display the moves history?(y/n)"
    answer = gets.chomp
    loop do
      break if (answer == "y" || answer == "n")
      puts "sorry, the input is wrong.(y/n)"
      answer = gets.chomp
    end
    return if answer == "n"
    puts ("Moves history for #{human.name} : ")
    @@moves_history[human.name].each_with_index do |move, idx|
      puts "#{idx + 1}. #{move}"
    end
    puts ("Moves history for #{computer.name} : ")
    @@moves_history[computer.name].each_with_index do |move, idx|
      puts "#{idx + 1}. #{move}"
    end
  end
  
  def play
    display_welcome_message
    loop do
      human.choose
      @moves_history[human.name] << human.move.value
      smart_choice || computer.choose
      @moves_history[computer.name] << computer.move
      system 'clear'
      display_moves
      display_winner
      display_score
      break if end_of_game?
      break unless play_again?
    end
    display_overall_winner
    display_moves_history?
    display_goodbye_message
  end
end

game1 = RPSGame.new

class Options < Computer  
  def self.chameleon(any_game)
    any_game.info[-2] || any_game.info[-1]
  end
  
  def self.rock_solid(any_game)
    any_game.info[-1]
  end
  
  def self.random
    Move::VALUES.sample
  end
  
  def self.unbeatable(any_game)
    any_game.find_enemy(from_game.info.last)
  end
end

game_info = Options.new(game1)
p game_info
game1.play