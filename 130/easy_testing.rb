require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

class NoExperienceError < RuntimeError
end

class BooleanTest < Minitest::Test

  def setup
    @value = 5
    @string = 'XyZ'
    @nil = nil
    @array = []
    @array1 = [2, 1]
    @employee = 'Bob'
    @list = [1, 2, 3]
  end

  def value_type
    puts @value.class
  end

  def test_odds
    assert_equal(true, @value.odd?)
  end

  def test_xyz
    assert_equal('xyz', @string.downcase)
  end

  def test_nil
    assert_nil(@nil)
  end

  def test_array_emptiness
    assert_empty(@array)
  end

  def test_inclusion
    assert_includes(@array1, 1)
  end

  def test_no_experience_error
    def hire(employee)
      if employee == 'Bob'
        raise NoExperienceError, 'this employee has no experience'
      else
        true
      end
    end
    assert_raises NoExperienceError do
      hire(@employee)
    end
  end

  def test_value_kind
    assert_kind_of(Numeric, @value)
  end

  def test_value_type
    assert_instance_of(Fixnum, @value)
  end

  def test_same_object
    def process(any_list)
      any_list
    end
    assert_same(@list, process(@list))
  end

  def test_refutes_includes_xyz
    refute_includes(@list, 'xyz')
  end
end

