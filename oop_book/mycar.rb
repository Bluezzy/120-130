class MyCar
  attr_accessor :color, :hours
  attr_reader :year
  
  def initialize(year, color, model)            
    @year = year
    @color = color
    @model = model
    @speed = 0
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
    puts "You stopped the car."
  end
  
  def spray_paint(c)
    self.color = c
    puts "Your car is now #{@color}."
  end
  
  def to_s
    puts "The car is a #{@color} #{@model} from #{@year}"
  end

end

=begin

car = MyCar.new("1980", "red", "Nissan")
car.speed_up(30)
car.brake(20)
car.stop
car.color = "green"
car.spray_paint("pink")

=end

car = MyCar.new("1977", "blue", "Subaru")
puts car

# MyCar.gas_mileage(13, 351)  # => "27 miles per gallon of gas"
