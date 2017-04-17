require 'pry'

module Screen
  def clear
    system 'clear'
  end

  def dealer_stays_and_display_hands
    puts "\ndealer decided to stay..."
    display_hands
    dealer.display_hand_total
  end

  def dealer_hitting_display
    clear
    puts "dealer decided to hit!"
    puts ""
    puts "dealer hits a #{dealer.hand.cards.last}"
    puts ""
  end

  def dealer_busted_display_and_game_over
    clear
    dealer.display_last_player_card
    puts "dealer busted! (#{dealer.hand.total})"
    puts ""
    self.game_over = true
  end

  def display_last_player_card
    puts "The card is: #{hand.cards.last}"
    puts ""
  end

  def show_hand
    if type == :player
      puts "You have:"
    else
      puts "Dealer has:"
    end
    hand.cards.each do |card|
      puts "   #{card}"
    end
  end

  def display_hand_total
    puts "Total of : #{hand.total}"
  end

  def show_hand_and_display_hand_total
    show_hand
    display_hand_total
  end

  def display_hidden_card
    puts "The dealer's hidden card was: #{dealer.hand.cards.last}!"
  end

  def display_hands
    puts ""
    player.show_hand_and_display_hand_total
    puts ""
    dealer.show_hand
  end

  def introduction_message
    puts "==>> Welcome to Twenty-One Game! <<=="
    puts ""
    puts "The deck is ready. Let's deal the cards."
    puts "Please press any key."
    gets.chomp
  end

  def show_result
    return if game_over
    puts ""
    if dealer_wins
      puts "Dealer wins !"
    elsif player_wins
      puts "You win!"
    else
      puts "It's a tie!"
    end
  end

  def display_dealer_hidden_card_and_hands
    clear
    reveal_hidden_card
    display_hidden_card
    puts ""
    dealer.show_hand_and_display_hand_total
    puts ""
    puts "Enter any key"
    gets.chomp
  end
end

class Hand
  attr_accessor :cards, :values, :total
  def initialize
    @cards = []
    @values = []
    @total = 0
  end

  def check(card)
    value = value(card)
    values << value
    update_total
  end

  def total_without_ace_correct
    count = 0
    values.each { |value| count += value }
    count
  end

  def ace_correct
    return unless total_without_ace_correct > 21
    values.map! do |value|
      if value == 11
        1
      else
        value
      end
    end
  end

  def update_total
    ace_correct
    self.total = values.reduce(:+)
  end

  def value(card)
    if ('2'..'10').to_a.include?(card.type)
      card.type.to_i
    elsif Card.figures.include?(card.type)
      10
    else
      ace_value
    end
  end

  def ace_value
    if total >= 11
      1
    else
      11
    end
  end
end

class Card
  attr_reader :name, :color, :type
  attr_accessor :state, :value
  def initialize(deck, state = :revealed)
    @name = deck.pop
    @type = @name[0]
    @color = @name[1]
    @state = state
  end

  def to_s
    if state == :revealed
      "#{type} of #{color}"
    else
      "???(hidden card)"
    end
  end

  def self.figures
    ['J', 'Q', 'K']
  end
end

class Participant
  include Screen
  attr_accessor :hand, :score
  attr_reader :type

  def initialize(type)
    @hand = Hand.new
    @score = 0
    @type = type
  end

  def hit(deck, state = :revealed)
    new_card = Card.new(deck, state)
    hand.check(new_card) # deal with aces values according to hand
    hand.cards << new_card
  end

  def busted?
    hand.total > 21
  end

  def to_s
    type.to_s
  end
end

module Deck
  def create_deck
    [['2', 'Diamonds'], ['3', 'Diamonds'], ['4', 'Diamonds'],
     ['5', 'Diamonds'], ['6', 'Diamonds'], ['7', 'Diamonds'],
     ['8', 'Diamonds'], ['9', 'Diamonds'], ['10', 'Diamonds'],
     ['J', 'Diamonds'], ['Q', 'Diamonds'], ['K', 'Diamonds'],
     ['A', 'Diamonds'], ['2', 'Heart'], ['3', 'Heart'], ['4', 'Hearts'],
     ['5', 'Hearts'], ['6', 'Hearts'], ['7', 'Hearts'], ['8', 'Hearts'],
     ['9', 'Hearts'], ['10', 'Hearts'], ['J', 'Hearts'], ['Q', 'Hearts'],
     ['K', 'Hearts'], ['A', 'Hearts'], ['2', 'Spades'], ['3', 'Spades'],
     ['4', 'Spades'], ['5', 'Spades'], ['6', 'Spades'], ['7', 'Spades'],
     ['8', 'Spades'], ['9', 'Spades'], ['10', 'Spades'], ['J', 'Spades'],
     ['Q', 'Spades'], ['K', 'Spades'], ['A', 'Spades'], ['2', 'Clubs'],
     ['3', 'Clubs'], ['4', 'Clubs'], ['5', 'Clubs'], ['6', 'Clubs'],
     ['7', 'Clubs'], ['8', 'Clubs'], ['9', 'Clubs'], ['10', 'Clubs'],
     ['J', 'Clubs'], ['Q', 'Clubs'], ['K', 'Clubs'], ['A', 'Clubs']].shuffle
  end
end

class Game
  HIT = ['h', 'hit']
  STAY = ['s', 'stay']
  HIT_OR_STAY = HIT + STAY
  include Screen
  include Deck
  attr_reader :deck, :player, :dealer
  attr_accessor :switch_turn, :game_over

  def initialize
    @deck = create_deck
    @player = Participant.new(:player)
    @dealer = Participant.new(:dealer)
    @switch_turn = false
    @game_over = false
  end

  def play
    clear
    introduction_message
    start
  end

  def start
    clear
    deal_cards
    display_hands
    player_turn
    dealer_turn
    show_result
  end

  def deal_cards
    player.hit(deck)
    dealer.hit(deck)
    player.hit(deck)
    dealer.hit(deck, :hidden_card)
  end

  def player_hit_mechanism
    player.hit(deck)
    clear
    player.display_last_player_card
  end

  def hit_or_stay?
    puts "\nWould you like to hit or stay ? ('h' for hit / 's' for stay)"
    answer = nil
    loop do
      answer = gets.chomp
      break if HIT_OR_STAY.include?(answer.downcase.strip)
      puts "Sorry, wrong input(h/s)"
    end
    if HIT.include?(answer.downcase.strip)
      player_hit_mechanism
    else
      self.switch_turn = true
    end
  end

  def player_turn
    loop do
      hit_or_stay?
      break if player.busted? || switch_turn
      display_hands
    end
    return unless player.busted?
    puts "You're busted ! (#{player.hand.total})"
    self.game_over = true
  end

  def reveal_hidden_card
    dealer.hand.cards.each do |card|
      card.state = :revealed
    end
  end

  def dealer_thinking
    return if dealer.busted?
    puts ""
    puts "Dealer is thinking...(press key)"
    gets.chomp
    clear
  end

  def dealer_hits
    dealer.hit(deck)
    dealer_hitting_display
    dealer.show_hand_and_display_hand_total
  end

  def dealer_hitting_and_thinking_process
    while dealer.hand.total < 17
      dealer_hits
      dealer_thinking
      break if dealer.busted?
    end
  end

  def dealer_wins
    dealer.hand.total > player.hand.total
  end

  def player_wins
    player.hand.total > dealer.hand.total
  end

  def dealer_turn
    return if game_over
    display_dealer_hidden_card_and_hands
    dealer_hitting_and_thinking_process
    if dealer.busted?
      dealer_busted_display_and_game_over
      return
    end
    dealer_stays_and_display_hands
  end
end

game = Game.new
game.play