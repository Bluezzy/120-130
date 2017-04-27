=begin

class Cat
  attr_accessor :name
  def self.generic_greeting
    puts "I'm a cat!"
  end

  def initialize(name)
    @name = name
  end

  def rename(new_name)
    self.name = new_name
  end

  def identity
    self
  end

  def greeting
    puts "My name is #{name}!"
  end
end

# kitty = Cat.new
# kitty.class.generic_greeting
# Cat.generic_greeting

kitty = Cat.new('Sophie')
puts kitty.name
kitty.rename('Chloe')
puts kitty.name

p kitty.identity

Cat.generic_greeting
kitty.greeting


class Cat
  @@number_of_cats = 0
  def initialize
    @@number_of_cats +=1
  end

  def self.total
    @@number_of_cats
  end
end

kitty1 = Cat.new
kitty2 = Cat.new

puts Cat.total


class Cat
  COLOR = 'purple'

  attr_reader :name

  def initialize(name)
    @name = name
    @color = COLOR
  end

  def greet
    puts "Hello ! My name is #{name} and I'm a #{COLOR} cat!"
  end
end

kitty = Cat.new('Sophie')
kitty.greet


class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
puts kitty


class Person
  attr_accessor :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret


class Person
  attr_writer :secret

  def share_secret
    get_secret
  end

  private

  attr_reader :secret

  def get_secret
    puts secret
  end
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

=end

class Person
  attr_writer :secret

  def compare_secret(other_person)
    secret == other_person.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)













































