# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo_object)
    raise TypeError, "can only add Todo object" unless todo_object.class == Todo
    @todos << todo_object
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    raise IndexError, "no object at index #{index}" unless index < @todos.size
    @todos[index]
  end

  def mark_done_at(idx)
    raise IndexError, "no object at index #{idx}" unless idx < @todos.size
    @todos[idx].done!
  end

  def mark_undone_at(idx)
    raise IndexError, "no object at index #{idx}" unless idx < @todos.size
    @todos[idx].undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(idx)
    raise IndexError, "no object at index #{idx}" unless idx < @todos.size
    @todos.delete_at(idx)
  end

  def to_s
    text = "------------Today's Todos:-------------\n"
    @todos.each do |item|
      text << "#{item}\n"
    end
    text
  end

  def to_a
  end

  def each
    index = 0
    while index < @todos.size
      yield(@todos[index])
      index +=1
    end
    self
  end

  def select
    list = TodoList.new(title)
    each do |item|
      boolean = yield(item)
      list.add(item) if boolean == true
    end
    list
  end

  def find_by_title(string)
    each do |item|
      return item if item.title == string
    end
    puts "There is no such title"
  end

  def all_done
    done_list = TodoList.new(title)
    select do |item|
      done_list << item if item.done?
    end
    done_list
  end

  def all_not_done
    undone_list = TodoList.new(title)
    select do |item|
      undone_list << item if !item.done?
    end
    undone_list
  end

  def mark_done(title)
    if find_by_title(title)
      find_by_title(title).done!
    end
  end

  def mark_all_done
    each { |todo| todo.done! }
  end

  def mark_all_undone
    each { |todo| todo.undone! }
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.mark_done_at(1)
list.mark_done_at(2)
list.mark_undone_at(1)

list.mark_all_done
puts list
list.mark_all_undone
puts list