=begin

class Device
  def initialize
    @recordings = []
  end

  def record(recording)
    @recordings << recording
  end

  def listen
    return unless block_given?
    recording = yield
    record(recording)
  end

  def play
    @recordings.each { |recording| puts recording }
  end
end

listener = Device.new
listener.listen { "Hello World!" }
listener.listen
listener.listen { "How are you?" }
listener.play # Outputs "Hello World!"

class TextAnalyzer
  def process
    text = File.read('random.txt')
    yield(text)
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "#{text.split(/\n\n/).size} paragraphs" }
analyzer.process { |text| puts "#{text.split(/\n/).size} lines" }
analyzer.process { |text| puts "#{text.split(' ').size } words" }

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  yield("#{items.join(', ')}")
end

gather(items) do |list|
  puts "Let's start gatherin food :"
  puts list
end

def last_elements_display(arr)
  yield(arr)
end

sentence = ['ignored', 'ignored', "Hello!", "How are you?", "I am fine"]

last_elements_display(sentence) do |_, _, *last_elements|
  puts "==> Sentence:\n#{last_elements.join("\n")}"
end

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |first_food, *last_foods|
  puts first_food
  puts last_foods.join(', ')
end

gather(items) do |first_item, *other_items, last_item|
  puts first_item
  puts other_items.join(', ')
  puts last_item
end

gather(items) do |first_item, *last_items|
  puts first_item
  puts last_items.join(', ')
end

gather(items) do |_, _, _, _|
  puts "#{items.join(', ')}"
end

def convert_to_base_8(n)
  n.to_s(8).to_i
end

# The correct type of argument must be used below
base8_proc = method(:convert_to_base_8).to_proc

# We'll need a Proc object to make this code work. Replace `a_proc`
# with the correct object
p [8,10,12,14,16,33].map(&base8_proc)

def factorial(n)
  return 1 if n == 1
  factorial(n-1) * n
end

f = Enumerator.new do |y|
  n = 1
  loop do
    y << factorial(n)
    n += 1
  end
end

f.take(7)

f.rewind

f.each_with_index do |number, index|
  puts "factorial #{index +=1} : #{number}"
  break if index == 7
end

=end

def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      if block_given?
        next if yield(array[index - 1], array[index])
      else
        next if array[index - 1] <= array[index]
      end

      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end

    break unless swapped
  end
  nil
end

a = [1, 2, 4, 3, 5, 7, 6, 0]
bubble_sort!(a) { |first, second| first >= second }
puts a



































