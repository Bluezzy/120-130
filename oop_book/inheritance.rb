
module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle  
  attr_accessor :color
  attr_reader :year
  attr_reader :number_of_vehicles
  
  @@nb_of_vehicles = 0
  
  def initialize(year, color, model)            
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@nb_of_vehicles += 1
  end
  
  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def speed_up(number)
    @speed += number
    puts "You're at a current speed of #{@speed} mph."
  end
  
  def brake(number)
    @speed -= number
    puts "You're at a current speed of #{@speed} mph."
  end
  
  def stop
    @speed = 0
    puts "You stopped the vehicle."
  end
  
  def spray_paint(c)
    self.color = c
    puts "Your vehicle is now #{@color}."
  end
  
  def to_s
    puts "The vehicle is a #{@color} #{@model} from #{@year}"
  end
  
  def self.number_of_vehicles
    @@nb_of_vehicles
  end
  
end

class MyCar < Vehicle
  CATEGORY = "middle_heavy"
end

class Truck < Vehicle
  CATEGORY = "heavy"
  include Towable
end


class Students
  attr_accessor :name
  attr_writer :grade
  
  def initialize(name, grade)
    @name = name
    @grade = grade
  end
    
  def better_grade_than?(name)
    @grade > name.grade
  end
  
  protected
  
  def grade
    @grade
  end
  
end
  
bob = Students.new("Bob", 16)

joe = Students.new("Joe", 14)

p joe.better_grade_than?(bob)