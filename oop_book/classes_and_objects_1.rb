

# STATES AND BEHAVIORS


# We use classes to create objects.
# When definining a class : States => attributes
#                           Behaviors => abilities

# Instance variables keep track of state,
# Instance methods expose behaviors for objects




# INITIALIZING A NEW OBJECT


#--------------------------------CODE------------------------------------#

# good_dog.rb

class GoodDog
  def initialize
    puts "This object was initialized !"
  end
end

sparky = GoodDog.new        # => "This object was initialized!"

#------------------------------------------------------------------------#

# We refer to the initialize method as a constructor, 
# because it gets triggered whenever we create a new object.




################################################################################
################################################################################




# INSTANCE VARIABLES


#--------------------------------CODE------------------------------------#

# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name           # instance variable. Exists as long as the object instance exists.
  end
end

  # You can pass arguments into the initialize method through the new method.
  # Let's create an object using the GoodDog class from above:

sparky = GoodDog.new("Sparky")

#-----------------------------------------------------------------------#


# Here, the string "Sparky" is being passed from the new method through to the 
# initialize method, and is assigned to the local variable name.

# Within the constructor (i.e., the initialize method), we then set 
# the instance variable @name to name, which results in 
# assigning the string "Sparky" to the @name instance variable.

# From that example, we can see that instance variables are responsible for 
# keeping track of information about the state of an object.
# Every object's state is unique, and instance variables are how we keep track.




################################################################################
################################################################################




# INSTANCE METHODS

# Right now, our GoodDog class can't really do anything. 
# Let's give it some behaviors.


#--------------------------------CODE------------------------------------#

# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf! " # We can expose information about the state of an object using instance methods.
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak

fido = GoodDog.new("Fido")
puts fido.speak

#------------------------------------------------------------------------#

#  all objects of the same class have the same behaviors, 
#  though they contain different states (here, the differing state is the name).




################################################################################
################################################################################




# ACCESSOR METHODS


#--------------------------------CODE------------------------------------#

# good_dog.rb

class GoodDog
  def initialize(name)
    @name = name
  end

# getter_method

  def name # If we want to access the object's name, 
    @name      # which is stored in the @name instance variable, 
  end          # we have to create a method that will return the name.   

# setter_method

  def name=(name) # we want to change the name 
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky") 
puts sparky.speak           # => Sparky says arf!
puts sparky.name            # => Sparky
sparky.name = "Spartacus"
puts sparky.name            # => Spartacus

#------------------------------------------------------------------------#

# Syntactical sugar :
# sparky.name = "Spartacus". When you see this code, just realize 
# there's a method called name= working behind the scenes.


# Ruby has a built-in way to automatically create these getter 
# and setter methods for us, using the attr_accessor method.

#--------------------------------CODE------------------------------------#

class GoodDog
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} says arf!"
  end
end

sparky = GoodDog.new("Sparky")
puts sparky.speak
puts sparky.name            # => "Sparky"
sparky.name = "Spartacus"
puts sparky.name            # => "Spartacus"

#------------------------------------------------------------------------#

# Self

# good_dog.rb

class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def speak
    "#{name} says arf!"
  end

  def change_info(n, h, w)
    self.name = n    # tells Ruby we're calling a setter method,
    self.height = h  # not creating local variable.
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end

sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
puts sparky.info      # => Sparky weighs 10 lbs and is 12 inches tall.

sparky.change_info('Spartacus', '24 inches', '45 lbs')
puts sparky.info      # => Spartacus weighs 45 lbs and is 24 inches tall.


























