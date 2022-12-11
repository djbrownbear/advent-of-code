f = File.read("input")
g = f.split("\r\n")

# split data into groups for each pair
g.map! { |el| el.split(/[-,]/) }

# PART 1

h = []

g.each do |group|
  nums = group.map(&:to_i)
  l_min,l_max,r_min,r_max = nums
  h << nums if (l_min<=r_min && l_max>=r_max) || (r_min<=l_min && r_max>=l_max)
end

p h.count

# PART 2

j = []
g.each do |group|
  nums = group.map(&:to_i)
  l_min,l_max,r_min,r_max = nums
  j << nums if (l_min<=r_max && l_max>=r_min) || (r_min<=l_max && r_max>=l_min)
end

p j.count