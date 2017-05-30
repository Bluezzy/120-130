require 'pry'

class PhoneNumber
  attr_accessor :number
  def initialize(number_input)
    @number_input = number_input
    @number = invalid? ? '0000000000' : clean(@number_input)
    remove_1 if eleven_digits_and_first_is_1?
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{self.area_code}) #{number[3..5]}-#{number[6..-1]}"
  end

  def clean(n)
    n.chars.select { |char| char.match(/\d/) }.join
  end

  def invalid?
    wrong_nb_of_digits? || letters?
  end

  def wrong_nb_of_digits?
    clean(@number_input).size != 10 && wrong_11_digits?
  end

  def wrong_11_digits?
    num = clean(@number_input)
    return true if num.size != 11
    num[0] != '1'
  end

  def remove_1
    self.number = number[1..-1]
  end

  def eleven_digits_and_first_is_1?
    number.size == 11 && number[0] == '1'
  end

  def letters?
    @number_input.chars.any? { |char| char.match(/[a-zA-Z]/) }
  end
end

phone = PhoneNumber.new('hfrej7676fhgjr87')
p phone.number
