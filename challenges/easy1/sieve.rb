class Sieve
  def initialize(limit)
    raise ArgumentError, 'Expected an integer' unless limit.is_a?(Integer)
    @limit = limit
    @crossed_numbers = []
    (@limit + 1).times do
      @crossed_numbers << false
    end
  end

  def primes
    cross_numbers
    collect_uncrossed_numbers
  end

  private

  def cross_numbers
    2.upto(@limit) do |gap|
      (gap..@limit).step(gap) do |n|
        @crossed_numbers[n] = true unless n == gap
      end
    end
  end

  def collect_uncrossed_numbers
    result = []
    @crossed_numbers.each_index do |idx|
      result << idx unless @crossed_numbers[idx]
      result.reject! { |prime| prime == 0 || prime == 1 }
    end
    result
  end
end
