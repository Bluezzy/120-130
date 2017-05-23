class Octal
  attr_reader :octal

  def initialize(octal_string)
    raise ArgumentError, 'We expect a string' unless octal_string.is_a?(String)
    @octal = octal_string
  end

  def valid?
    octal.chars.all? { |digit| ('0').upto('7').include?(digit) }
  end

  def to_decimal
    return 0 unless valid?
    digits = octal.chars.map(&:to_i)
    bigger_power_value =  digits.size
    index = 0
    result = 0
    1.upto(bigger_power_value) do |n|
      result += digits[index]*8**(bigger_power_value - n)
      index += 1
      break if index >= bigger_power_value
    end
    result
  end
end

