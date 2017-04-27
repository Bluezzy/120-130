require 'pry'

module Mailable
  def print_address
    puts "#{name}"
    puts "#{address}"
    puts "#{city}, #{state} #{zipcode}"
  end
end

class Customer
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

class Employee
  include Mailable
  attr_reader :name, :address, :city, :state, :zipcode
end

module Drivable
  def drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive

class House
  attr_reader :price
  include Comparable

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

class Transform
  def initialize(string)
    @string = string
  end

  def self.lowercase(str)
    str.downcase
  end

  def uppercase
    @string.upcase
  end
end

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected

  attr_reader :amount
end

class Pet
  attr_reader :type, :name
  def initialize(type, name)
    @type = type
    @name = name
  end
end

class Owner
  attr_accessor :number_of_pets
  attr_reader :name, :pets
  def initialize(name)
    @name = name
    @pets = []
    @number_of_pets = 0
  end

  def <<(pet)
    @pets << pet
  end
end

class Shelter
  def initialize
    @owners = []
  end

  def adopt(owner, pet)
    owner << pet
    owner.number_of_pets += 1
    add(owner) if @owners.empty?
    add?(owner)
  end

  def add?(any_owner)
    @owners.each do |other_owner|
      if any_owner.equal?(other_owner)
        return
      end
    end
    add(any_owner)
  end

  def add(any_owner)
    @owners << any_owner
  end

  def print_adoptions
    @owners.each do |owner|
      puts ""
      puts "#{owner.name} has adopted the following pets:"
      owner.pets.each do |pet|
        puts "a #{pet.type} named #{pet.name}"
      end
    end
    puts ""
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

=begin

shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

≠≠P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

=end

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

module Walkable
  def walk
    puts "#{self.name} #{gait} forward"
  end
end

class Noble
  include Walkable
  attr_reader :title

  def initialize(name, title)
    @name = name
    @title = title
  end

  def name
    @title + ' ' + @name
  end

  private

  def gait
    "struts"
  end

end

class Person
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "runs"
  end
end

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

noble = Noble.new("Byron", "Lord")
noble.walk