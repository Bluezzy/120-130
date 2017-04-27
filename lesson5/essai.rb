class Pet
  attr_accessor :pets
  def initialize
    @pets = []
  end

  def change_name
    pets.each do |pet|
      pet.name = 'wolf'
    end
  end
end

class Dog
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

dog1 = Dog.new('Spidou')
puts dog1

garderie = Pet.new

garderie.pets << dog1

p garderie
p dog1

garderie.change_name

p dog1
p garderie
