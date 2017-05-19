def select(array)
  selected_array = []
  array.each do |n|
    boolean = yield(n)
    selected_array << n if boolean == true
  end
  selected_array
end

p select([2, 3, 4, 5]) { |num| num.even? }
