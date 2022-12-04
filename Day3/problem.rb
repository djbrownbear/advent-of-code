require "set"

f = File.read("input")
g = f.split("\r\n")

# PART 1
lower_case = ("a".."z").to_a
upper_case = ("A".."Z").to_a
items = lower_case.concat(upper_case)
items.unshift("\n")

priority = []

g.each do |sack|
  half = sack.length / 2 
  first, second = sack[0...half], sack[half..-1]

  cur_priority = Hash.new { |h,k| h[k] = 0 }

  first.each_char do |char1|
    second.each_char do |char2|
      if !cur_priority.key?(char1) && char1 == char2
        cur_priority[char1] = items.index(char1)   
      end
    end
  end

  priority << cur_priority.values
end

p priority.flatten.sum

# PART 2
h = g.each_slice(3).to_a

badges = []

h.each do |group|
  sets = group.map { |elf| elf.split("").to_set }
  # use set's built in intersection method to find common element
  # to identify badge
  badge = sets[0] & sets[1] & sets[2]
  badges << badge.to_a.first
end

priorities2 = badges.map { |el| items.index(el) }
p priorities2
p priorities2.sum