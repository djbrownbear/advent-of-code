require "byebug"

class Stacks
  FILENAME = File.read("input")
  DATA = FILENAME.split("\r\n")

  
  def initialize
    @data = DATA
    @stacks = Hash.new { |h,k| h[k] = [] }
    @indices = [parse_stackline(@data.first).each]
  end
  
  attr_reader :stacks, :indices, :data
  
  def parse_stackline(line)
    parsed = line.chars.each_slice(4).map(&:join).map {|el| el.chars[1]}
    parsed
  end

  def parse_instructions(line)
    line.scan(/\d/).map(&:to_i)
  end

  def add_to_stack(arr)
    puts "before: #{@stacks}"
    arr.each_with_index { |char, i| @stacks[i + 1] << char }
    puts "after: #{@stacks}"
  end

  def add_indices(arr)
    parse_stackline(arr).each_with_index { |char, i| indices << i }
  end

  def move_stacks(quantity, source, dest)
    # debugger
    puts "#{quantity} #{source} #{dest}"
    puts "before move: #{@stacks}"
    quantity.times { stacks[dest].unshift stacks[source].shift }
    puts "after move: #{@stacks}"
  end

  def reverse_stack
    @stacks = @stacks.map { |k,v| v.reverse }
  end

  def clean_stack
    @stacks = @stacks.each do |k,v| 
      # puts "before clean: #{@stacks}"
      @stacks[k] = v.reject { |el| el == nil || el == " " || el.match?(/\d/) }
      # puts "after clean: #{@stacks}"
    end
  end

  def run
    @data.each do |line|
      if line.index("[") || line.index("]")
        add_to_stack(parse_stackline(line))
      elsif line.length == 0
        print "starting instructions...\n"
      elsif line.index("move") && line.scan(/\d/).count == 3
        self.clean_stack
        quantity, source, dest = parse_instructions(line)
        move_stacks(quantity, source, dest)
      end 
    end
    p @stacks.values.map(&:first).join
  end
end

  stackers = Stacks.new
  stackers.run

if $PROGRAM_NAME == __FILE__
  stackers = Stacks.new
  stackers.run
end