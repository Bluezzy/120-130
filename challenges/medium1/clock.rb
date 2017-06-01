class Clock
  MAXIMUM_MINUTES_IN_A_DAY = 60 * 24
  attr_accessor :total_minutes, :hours, :minutes

  def initialize(h, m)
    @hours = h
    @minutes = m
    @total_minutes = @hours * 60 + @minutes
  end

  def self.at(hours, minutes = 0)
    raise TypeError, "we need integers" unless hours.is_a?(Integer) && minutes.is_a?(Integer)
    raise ArgumentError, "numbers are too high" if hours >= 24 || minutes >= 60
    new(hours, minutes)
  end

  def +(num)
    self.total_minutes = (total_minutes + num) % MAXIMUM_MINUTES_IN_A_DAY
    update_clock
    self
  end

  def -(num)
    self.total_minutes = (total_minutes - num) % MAXIMUM_MINUTES_IN_A_DAY
    update_clock
    self
  end

  def ==(other_clock)
    self.total_minutes == other_clock.total_minutes
  end

  def update_clock
    self.hours, self.minutes = total_minutes.divmod(60)
  end

  def to_s
    "#{format(hours)}:#{format(minutes)}"
  end

  def format(number)
    (0..9).include?(number) ? "0#{number}" : "#{number}"
  end
end
