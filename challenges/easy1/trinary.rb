class Trinary
  VALID_CHARACTERS = ['0', '1', '2']
  attr_reader :digits

  def initialize(str)
    @chars = str.chars
    @digits = @chars.map(&:to_i)
  end

  def to_decimal
    valid? ? calculate : 0
  end

  private

  def valid?
    @chars.all? { |char| VALID_CHARACTERS.include?(char) }
  end

  def calculate
    values = []
    digits.reverse.each_with_index { |digit, idx| values << (digit * 3**idx) }
    values.reduce(:+)
  end
end
