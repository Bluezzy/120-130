class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
  
  # to solve Hello.Hi issue
  def self.hi
    greeting = Greeting.new
    greeting.greet("hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

hello = Hello.new

# hello.hi 
  #ruby will find the hi method on the first class that ruby looks for,
  #which is the Hello class. greet("hello") will be executed. Ruby will
  #look for greet method in the Hello class and won't find it, so it will
  # be found in the nearest superclass, which is Greeting.
  # final output : "Hello'

# hello.bye 
  # Ruby will look for the method bye on the Hello class and its 
  #superclass Greeting. there's no bye method there. the bye method
  # is on the Goodbye which is a subclass of Greeting, not available
  # in the method lookup chain (it "looks up" to superlcasses and doesn't
  # "look down" to subclasses, that's the principle of inheritance.

# hello.greet 
  # Ruby won't find the greet method on the Hello class but it will find
  #it on its superclass Greeting. However, the greet message recquires
  # a message to be passed in as an argument, so it will throw an error.

# hello.greet("Goodbye") 
  #now that the message is passed as an argument, it will 
  #have the expected behavior and output "Goodbye"

puts Hello.hi
  # we're trying to call a method directly from the Hello class, which suppose
  # we're looking for a class method. there's no class method in the Hello class.
  # hi is an instance method. we need a class defined by self.hi within the Hello
  # class that we can call directly from the class with Hello.hi
  
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

cat1 = AngryCat.new(19, "misgiuccia")
cat2 = AngryCat.new(12, "Ted")

puts cat1.inspect
puts cat2.inspect

class Cat
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{@type} cat."
  end
end

misgiuccia = Cat.new("european")
puts misgiuccia

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

tv = Television.new
tv.manufacturer #instance method not available 
tv.model

Television.manufacturer
Television.model #class method not available

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    @age += 1
  end
end
