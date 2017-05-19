require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!

require_relative 'todolist_solution'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@list.size, @todos.size)
  end

  def test_first
    assert_equal(@list.first, @todo1)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift
    assert_equal(todo, @todo1)
    assert_equal([@todo2, @todo3], @list.to_a)
  end

  def test_pop
    todo = @list.pop
    assert_equal(todo, @todo3)
    assert_equal(@list.to_a, [@todo1, @todo2])
  end

  def test_done?
    assert_equal(@list.done?, false)
  end

  def test_type_error
    string = 'string object'
    assert_raises(TypeError) { @list << string }
    assert_raises(TypeError) { @list.add(1) }
  end

  def test_shovel_method
    new_todo = Todo.new("Walk the dog")
    @list << new_todo
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end

  def test_add_alias
    new_todo = Todo.new("Feed the cat")
    @list.add(new_todo)
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_equal(@list.item_at(0), @todo1)
    assert_raises(IndexError) { @list.item_at(100) }
    assert_raises(IndexError) { @list.item_at(-100) }
  end

  def test_mark_done_at
    @list.mark_done_at(1)
    assert_equal(@todo2.done?, true)
    assert_raises(IndexError) { @list.mark_done_at(100) }
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_done_at(100) }
    @list.done!
    @list.mark_undone_at(1)
    assert_equal(@todo1.done?, true)
    assert_equal(@todo2.done?, false)
    assert_equal(@todo3.done?, true)
  end

  def test_done!
    @list.mark_all_undone
    assert_equal(@todo1.done?, false)
    assert_equal(@todo2.done?, false)
    assert_equal(@todo3.done?, false)
    @list.done!
    assert_equal(@todo1.done?, true)
    assert_equal(@todo2.done?, true)
    assert_equal(@todo3.done?, true)
    assert_equal(@list.done?, true)
  end

  def test_remove_at
    removed_item = @list.remove_at(0)
    assert_equal(removed_item, @todo1)
    assert_equal([@todo2, @todo3], @list.to_a)
    assert_raises(IndexError) { @list.remove_at(100) }
  end

  def test_to_s
    output = <<-OUTPUT.chomp
---- Today's Todos ----
[ ] Buy milk
[ ] Clean room
[ ] Go to gym
OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<-OUTPUT.chomp
---- Today's Todos ----
[ ] Buy milk
[X] Clean room
[ ] Go to gym
OUTPUT

    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<-OUTPUT.chomp
---- Today's Todos ----
[X] Buy milk
[X] Clean room
[X] Go to gym
OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    result = []
    @todos.each do |todo|
      result << todo
    end
    assert_equal(@todos, result)
  end

  def test_each_2
    returned_object = @todos.each {|todo| next}
    assert_equal(@todos, returned_object)
  end

  def test_select
    @list.mark_done_at(0)
    new_list = TodoList.new(@list.title)
    new_list.add(@todo1)
    selected_list = @list.select {|todo| todo.done?}
    assert_equal(new_list.to_s, selected_list.to_s)
  end

end