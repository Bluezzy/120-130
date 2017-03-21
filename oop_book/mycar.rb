class MyCar
  
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
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
  
end


car = MyCar.new("1980", "red", "Nissan")
car.speed_up(30)
car.brake(20)
car.stop