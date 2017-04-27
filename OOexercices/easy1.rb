require 'pry'

class Banner
  def initialize(message)
    @message = message
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    '+' + '-'*(@message.size + 2) + '+'
  end

  def empty_line
    '| ' + ' '*@message.size + ' |'
  end

  def message_line
    "| #{@message} |"
  end
end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end

  def name
    @name
  end
end

=begin

class Book
  attr_reader :title, :author
  def initialize(author, title)
    @author = author
    @title = title
  end

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=end

class Book
  attr_accessor :title, :author
  def to_s
    %("#{title}", by #{author})
  end
end

class Person
  def initialize(first_name, last_name)
    @first_name = first_name.capitalize
    @last_name = last_name.capitalize
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end

  def first_name=(first_name)
    @first_name = first_name.capitalize
  end

  def last_name=(last_name)
    @last_name = last_name.capitalize
  end
end

class Flight

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

=begin

class Car
  attr_accessor :mileage

  def initialize
    @mileage = 0
  end

  def increment_mileage(miles)
    total = mileage + miles
    self.mileage = total
  end

  def print_mileage
    puts mileage
  end
end

=end

class Rectangle
  def initialize(height, width)
    @height = height
    @width = width
  end

  def area
    @height * @width
  end
end

class Square < Rectangle
  def initialize(height)
    super(height, height)
  end
end

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  def initialize(name, age, fur_color)
    super(name, age)
    @fur_color = fur_color
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@fur_color} fur."
  end
end

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
end

class Car < Vehicle
  def wheels
    4
  end
end

class Motorcycle < Vehicle
  def wheels
    2
  end
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    6
  end
end

truck = Truck.new("hi", "hello", 2)
puts truck.wheels
puts truck.payload
puts truck.make
puts truck.model

