def step(from, to, step)
  value = from
  values = []
  loop do
    yield(value)
    value += step
    values << value
    break if value > to
  end
  values
end

def zip(arr1, arr2)
  index = 0
  result = []
  loop do
    result << [arr1[index], arr2[index]]
    index += 1
    break unless ( !!arr1[index] && !!arr2[index] )
  end
  result
end

def map(collection)
  transformed_collection = []
  collection.each do |element|
    transformed_element = yield(element)
    transformed_collection << transformed_element
  end
  transformed_collection
end

def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end
  array[index..-1]
end

def each_with_index(array)
  index = 0
  while index < array.size
    yield(array[index], index)
    index += 1
  end
  array
end

def each_with_object(array, object)
  array.each { |item| yield(item, object) }
  object
end


def max_by(arr)
  return nil if arr.empty?
  return arr[0] if arr.size == 1
  max_element = arr[0]
  index = 0
  max_result = yield(arr[0])
  loop do
    index += 1
    break unless arr[index]
    if yield(arr[index]) > max_result
      max_element = arr[index]
      max_result = yield(arr[index])
    end
  end
  max_element
end

def each_cons(array, n)
  index = 0
  nb_of_iterations = array.size - (n - 1)
  nb_of_iterations.times do
    yield(*array[index..(index + n - 1)])
    index += 1
  end
  nil
end


