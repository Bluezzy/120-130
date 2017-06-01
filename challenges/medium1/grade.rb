class School
  attr_accessor :list
  def initialize
    @list = {}
  end

  def to_h
    sort
    list
  end

  def add(student, grade)
    add_to_existing(student, grade) || list[grade] = [student]
  end

  def add_to_existing(student, grade)
    return false unless list.key?(grade)
    list[grade] << student
  end

  def grade(num)
    list[num] || []
  end

  def sort
    list.each { |_, students| students.sort! }
    self.list = list.sort.to_h
  end
end
