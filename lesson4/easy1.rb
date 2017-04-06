
true.class #=> TrueClass
TrueClass.ancestors # => [TrueClass, Object, Kernel, BasicObject]

"hello".class # => String 
String.ancestors # => [String, Comparable, Object, Kernel, BasicObject]

[1, 2, 3, "happy days"].class # => Array
Array.ancestors # => [Array, Enumerable, Object, Kernel, BasicObject]

142.class # => Fixnum
Fixnum.ancestors # => [Fixnum, Integer, Numeric, Comparable, Object, Kernel, BasicObject]

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
    include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
    include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

# car = Car.new
# car.go_fast

class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

# street_cat = AngryCat.new
# puts street_cat.inspect #=> #<AngryCat:0x0000000275b280>

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

apple = Fruit.new("apple")
pizza1 = Pizza.new("reine blanche")

# puts apple.instance_variables
# puts pizza1.instance_variables

class Cube
  attr_reader :volume
  
  def initialize(volume)
    @volume = volume
  end
  
  def to_s
    self.class
  end
end

cube = Cube.new(55)
puts cube.to_s

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

bag = Bag.new("green", "plastic")
puts bag.inspect