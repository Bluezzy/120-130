class AnyClass
  attr_accessor :number
  
  def initialize(number)
    @number = number
  end
end

OBJECT = AnyClass.new(6)

class AnotherClass
  def self.class_method
    p OBJECT.number + 4
  end
end

AnotherClass.class_method # => 10

