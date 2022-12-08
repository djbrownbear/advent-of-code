require "byebug"

class Stacks
  FILENAME = File.read("test_input")
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
    arr.each_with_index { |char, i| @stacks[i + 1] << char }
  end

  def add_indices(arr)
    parse_stackline(arr).each_with_index { |char, i| indices << i }
  end

  def move_stacks(quantity, source, dest)
    debugger
    quantity.times do 
     val = @stacks[source].first
     @stacks[source] = @stacks[source][1..-1]
     p "moving #{val} from #{source} to #{dest}"
     begin
      @stacks[dest].insert(0, val)
     rescue
      @stacks[dest] = [val]      
     end
    end
  end

  def reverse_stack
    @stacks = @stacks.map { |k,v| v.reverse }
  end

  def clean_stack
    @stacks = @stacks.reject { |k,v| v == " " } 
  end

  def run
    @data.each do |line|
      if line.index("[") || line.index("]")
        add_to_stack(parse_stackline(line))
      elsif line.scan(/\w/).empty?
        p line
      elsif line.length == 0
        print "starting instructions...\n"
        # self.reverse_stack
        # self.clean_stack
      else
        # p line
        quantity, source, dest = parse_instructions(line)
        move_stacks(quantity, source, dest)
      end 
    end
    p @stacks
  end
end

  stackers = Stacks.new
  stackers.run

if $PROGRAM_NAME == __FILE__
  stackers = Stacks.new
  stackers.run
end