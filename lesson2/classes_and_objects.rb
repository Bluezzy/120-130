class Person
  attr_accessor :last_name, :first_name
  
  def initialize(name)
    @name = name
    @first_name = name.split.first
    @last_name = name.split.size > 1 ? name.split.last : ''
  end

  def name
    "#{first_name} #{last_name}"
  end
  
  def name=(n)
    if n.split.size > 1
      @first_name = n.split.first
      @last_name = n.split[1..-1].join(' ')
    else
      @first_name = n
      @last_name = ''
    end
    @name = n
  end
  
  def to_s
    name
  end
 
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name   

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name       
p bob.name

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p rob.name == bob.name

puts "The person's name is: " + bob.name