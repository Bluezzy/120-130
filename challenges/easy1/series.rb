class Series
  def initialize(str)
    @digits = str.chars.map(&:to_i)
  end

  def slices(n)
    raise ArgumentError if n > @digits.size
    index = 0
    result = []
    loop do
      starting_index = index
      ending_index = index + (n - 1)
      break if ending_index >= @digits.size
      result << @digits[starting_index..ending_index]
      index += 1
    end
    result
  end
end
