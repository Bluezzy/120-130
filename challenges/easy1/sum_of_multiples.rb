class SumOfMultiples
  attr_reader :multiples

  DEFAULT_MULTIPLES = [3, 5]
  @@multiple1_def = DEFAULT_MULTIPLES[0]
  @@multiple2_def = DEFAULT_MULTIPLES[1]

  def initialize(m1 = 3, m2 = 5, *other_multiples)
    @multiples = [m1, m2, other_multiples].flatten
  end

  def self.to(limit)
    _multiples = []
    DEFAULT_MULTIPLES.each{ |mul| _multiples << mul }
    case limit
    when (0...@@multiple1_def)
      return 0
    when (@@multiple1_def...@@multiple2_def)
      return @@multiple1_def
    when @@multiple2_def
      return @@multiple1_def + @@multiple2_def
    else
      6.upto(limit - 1) do |n|
        _multiples += [n] if _multiples.any?{ |multiple| n % multiple == 0 }
      end
      return _multiples.reduce(:+)
    end
  end

  def to(limit)
    checking_range = 1.upto(limit - 1).to_a
    checking_range.each { |number| multiples << number if multiple?(number) }
    multiples.uniq.reduce(:+)
  end

  private

  def multiple?(n)
    multiples.any? { |multiple| n % multiple == 0 }
  end
end