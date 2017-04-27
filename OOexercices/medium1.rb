class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private

  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

class FixedArray
  attr_reader :array

  def initialize(length)
    @array = Array.new(length)
  end

  def to_s
    to_a.to_s
  end

  def to_a
    @array.clone
  end

  def [](index)
    @array.fetch(index)
  end

  def []=(index, value)
    @array[index] = value
  end
end

=begin
fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

=end

class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super
  end
end

class Minilang
  ACTIONS = %w(PUSH POP PRINT MOD DIV MULT SUB ADD)

  def initialize(string)
    @register = 0
    @commands = string.split
    @stack = []
  end

  def eval
    @commands.each do |command|
      if ACTIONS.include?(command)
        case command
        when 'PUSH' then @stack.push(@register)
        when 'POP' then @register = @stack.pop
        when 'ADD' then @register += @stack.pop
        when 'SUB' then @register -= @stack.pop
        when 'MULT' then @register *= @stack.pop
        when 'MOD' then @register %= @stack.pop
        when 'DIV' then @register /= @stack.pop
        when 'PRINT' then puts @register
        end
      else
        @register = command.to_i
      end
    end
  end
end

#Minilang.new('PRINT').eval
# 0

#Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

#Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

#Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

#Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

#Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

#Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

#Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

#Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

#Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

class GuessingGame
  attr_reader :number, :range_start, :range_stop
  attr_accessor :guess_number, :limit, :right_guess

  def initialize(range_start, range_stop)
    @range_start = range_start
    @range_stop = range_stop
    @size_of_range = range_stop - range_start
    @guess_number = 0
    @range = (range_start..range_stop)
    @number = rand(@range)
    @limit = Math.log2(@size_of_range).to_i + 1
    @right_guess = false
  end

  def ask_number
    answer = nil
    loop do
      puts "\nChose a number between #{range_start} and #{range_stop}"
      answer = gets.chomp
      if answer.to_i.to_s != answer
        puts "wrong input"
      elsif !@range.include? answer.to_i
        puts "The number is out of range."
      else
        break
      end
    end
    answer.to_i
  end

  def guess
    self.guess_number = ask_number
    self.limit -= 1
  end

  def bigger?
    guess_number > number
  end

  def smaller?
    guess_number < number
  end

  def right_guess?
    guess_number == number
  end

  def limit_reached?
    limit == 0
  end

  def display_remaining_guesses
    puts "You have #{limit} guesses remaining."
  end

  def outplay_final_result
    if right_guess?
      puts "You found the right number : #{number}. Congratulations !"
    elsif limit_reached?
      puts "I'm sorry. You don't have anymore guess."
    end
  end


  def game_over?
    right_guess? || limit_reached?
  end

  def advice
    system 'clear'
    if bigger?
      puts "Your guess is too high"
    elsif smaller?
      puts "Your guess is too low"
    end
  end

  def play
    loop do
      display_remaining_guesses
      guess
      break if game_over?
      advice
    end
    outplay_final_result
  end
end

class Card
  attr_reader :rank, :suit
  include Comparable

  VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def value
    VALUES.fetch(@rank, @rank)
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def ==(other_card)
    rank == other_card.rank && suit == other_card.suit
  end
end

require 'pry'

class Deck
  attr_reader :deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    @deck = []
    initialize_deck
  end

  def initialize_deck
    cards = RANKS.product(SUITS).shuffle
    cards.each do |card|
      @deck << Card.new(card[0], card[1])
    end
  end

  def reset
    initialize_deck
  end

  def empty?
    @deck.count == 0
  end

  def draw
    card = deck.sample
    deck.delete(card)
    reset if deck.empty?
    card
  end
end

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 }
puts ( drawn.count do |card|
  card.suit == 'Hearts'
end)


drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.
