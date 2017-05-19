require 'pry'

class Tree
  include Enumerable

  def each
  end

end

def compute
  return 'Does not compute.' unless block_given?
  yield
end

def missing(sorted_array)
  missing_integers = []
  (sorted_array.first).upto(sorted_array.last).each do |int|
    missing_integers << int unless sorted_array.include?(int)
  end
  missing_integers.sort
end

def divisors(n)
  divisors = []
  1.upto(n).each do |i|
    divisors << i if n % i == 0
  end
  divisors
end

encrypted_list =
"Nqn Ybirynpr
Tenpr Ubccre
Nqryr Tbyqfgvar
Nyna Ghevat
Puneyrf Onoontr
Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv
Wbua Ngnanfbss
Ybvf Unyog
Pynhqr Funaaba
Fgrir Wbof
Ovyy Tngrf
Gvz Orearef-Yrr
Fgrir Jbmavnx
Xbaenq Mhfr
Wbua Ngnanfbss
Fve Nagbal Ubner
Zneiva Zvafxl
Lhxvuveb Zngfhzbgb
Unllvz Fybavzfxv
Tregehqr Oynapu"

encrypted_names = encrypted_list.split(/\n/)

def rot13_opposite_letter(letter)
  return ' ' if letter == ' '
  return '-' if letter == '-'
  alphabet = ('a').upto('z').to_a
  first_half = alphabet.slice(0, 13)
  second_half = alphabet.slice(13, 13)
  rot13_alphabet = [first_half, second_half]
  if first_half.include?(letter)
    idx = first_half.find_index(letter)
    second_half[idx]
  elsif second_half.include?(letter)
    idx = second_half.find_index(letter)
    first_half[idx]
  end
end

def rot13_opposite_name(word)
  chars = word.downcase.chars
  chars.each do |char|
    char.gsub!(char, rot13_opposite_letter(char))
  end
  chars.join('')
end

def capitalize_all(string)
  string.split(' ').map!(&:capitalize).join(' ')
end

puts rot13_opposite_name('obiwan kenobi')

result = encrypted_names.map do |name|
  capitalize_all(rot13_opposite_name(name))
end

puts result