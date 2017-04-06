class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
puts oracle.predict_the_future

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# the choices method will override the choices method on the Oracle class.

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

puts HotSauce.ancestors
puts Orange.ancestors

class BeesWax
    attr_accessor :type
  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# Television.manufacturer

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

# the class variable @@cats_count is initialized within the class scope.
# When we create an instance of that class, the method initialize gets called.
# we increase the value of the class variable by 1. so every time we create an
# instance of the class, the @@cats_count is increased by one.
# It keeps track of the number of instances created by the class.
# To access this number, we can call the class method cats.count on the
# Cat class, because this methods always return the value contained by 
# the class variable @@cats_count.

Cat.new("european")
Cat.new("tigre")
puts Cat.cats_count # => 2

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
  
  def play
    "Start Bingo game!"
  end
end


# if we define a play method within the Bingo class, it will override
# the play method on its superclass Game.

new_game = Game.new
second_game = Bingo.new
puts new_game.play #method on the Game class called
puts second_game.play #method on the Bingo class called
