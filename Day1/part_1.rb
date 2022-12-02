f = File.read("input")
g = f.split(("\n")).map(&:to_i) # "\n" escape chars turn to zeroes when converted to integer

max = 0
sum = 0

# PART 1
g.each do |cal|
  if cal != 0
    sum += cal
  else
    max = sum if sum > max
    sum = 0
  end
end

p max

elf_sum = 0
totals = []

# PART 2
g.each do |cal|
  if cal != 0
    elf_sum += cal
  else
    totals << elf_sum
    elf_sum = 0
  end
end

top_3 = totals.sort.reverse[0..2]

p top_3.sum
