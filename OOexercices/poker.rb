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

class PokerHand
  attr_accessor :cards
  def initialize(deck)
    @cards = []
    5.times do
      @cards << deck.draw
    end
  end

  def print
    cards.each do |card|
      puts card
    end
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def get_ranks
    ranks = []
    cards.each do |card|
      ranks << card.rank
    end
    ranks
  end

  def get_suits
    suits = []
    cards.each do |card|
      suits << card.suit
    end
    suits
  end

  def ranks_of_same_kind?(number)
    ranks = get_ranks
    ranks.each do |rank|
      return true if ranks.count(rank) == number
    end
    false
  end

  def royal_flush?
    sum = 0
    cards.each do |card|
      sum += card.value
    end
    straight_flush? &&  sum == 60
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    ranks_of_same_kind?(4)
  end

  def full_house?
    pair? && three_of_a_kind?
  end

  def flush?
    suits = []
    cards.each do |card|
      suits << card.suit
    end
    suits.uniq.size == 1
  end

  def straight?
    values = []
    cards.each do |card|
      values << card.value
    end
    values.sort!
    checker = []
    counter = values.min
    5.times do
      checker << counter
      counter += 1
    end
    checker == values
  end

  def three_of_a_kind?
    ranks_of_same_kind?(3)
  end

  def two_pair?
    ranks = get_ranks
    ranks.uniq.size == 3 && !three_of_a_kind?
  end

  def pair?
    ranks_of_same_kind?(2)
  end
end

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
hand.print
puts hand.evaluate
puts ""

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
hand.print
puts hand.evaluate
puts ""