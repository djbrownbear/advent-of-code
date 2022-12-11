f = File.read("input")
g = f.split("\r\n")

# LEGEND
# A = ROCK || X = ROCK  
# B = PAPER || Y = PAPER
# C = SCISSORS || Z = SCISSORS

points = { "A" => 1, "B" => 2, "C" => 3, "X" => 1, "Y" => 2, "Z" => 3  }
total_score = 0

def is_win?(p1_guess, p2_guess)
  # helper method to determine points based of the outcome of the round
  outcomes = {"win"=> 6, "draw" => 3,  "loss" => 0}
  case p1_guess
  when "A"
    if p2_guess == "Y"
      outcomes["win"]
    elsif p2_guess == "X"
      outcomes["draw"]
    else
      outcomes["loss"]
    end
  when "B"
    if p2_guess == "Z"
      outcomes["win"]
    elsif p2_guess == "Y"
      outcomes["draw"]
    else
      outcomes["loss"]
    end
  else
    if p2_guess == "X"
      outcomes["win"]
    elsif p2_guess == "Z"
      outcomes["draw"]
    else
      outcomes["loss"]
    end
  end
end

# PART 1

g.each do |round|
  round_score = 0
  p1, p2 = round.split(" ")
  # add points to score for shape selected and outcome of the round
  round_score += points[p2] + is_win?(p1, p2)
  total_score += round_score 
end

p total_score

# PART 2

def get_round_score(guess)
  # helper method to determine points based of the outcome of the round
  outcomes = {"win"=> 6, "draw" => 3,  "loss" => 0}
  mapped = {
    "A X" => 3 + outcomes["loss"],
    "B X" => 1 + outcomes["loss"],
    "C X" => 2 + outcomes["loss"],
    "A Y" => 1 + outcomes["draw"],
    "B Y" => 2 + outcomes["draw"],
    "C Y" => 3 + outcomes["draw"],
    "A Z" => 2 + outcomes["win"],
    "B Z" => 3 + outcomes["win"],
    "C Z" => 1 + outcomes["win"],
  }

  mapped[guess]
end

part2_total = 0

g.each do |guess|
  round_score = 0
  # add points to score for shape selected and outcome of the round
  round_score += get_round_score(guess)
  part2_total += round_score 
end

p part2_total