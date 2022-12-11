f = File.read("input")
g = f.split("\r\n")

def get_uniq_group_index(arr, n)
  (0...arr.length-n-1).each do |i|
    group = arr[i..i+n-1]
    return i+n if group.chars.uniq.count == n
  end
end

p "PART 1"
g.each do |line|
  p "#{get_uniq_group_index(line, 4)} : #{line}"
end

p "PART 2"
g.each do |line|
  p "#{get_uniq_group_index(line, 14)} : #{line}"
end