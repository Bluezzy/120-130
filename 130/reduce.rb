def reduce(array, counter = 0)
  result = counter
  array.each do |num|
    result = yield(result, num)
  end
  result
end

array = [1, 2, 3, 4, 5]

puts reduce(array, 2) { |acc, num| acc * num }
puts reduce(array, 10) { |acc, num| acc + num }
puts reduce(array) { |acc, num| acc + num if num.odd? }