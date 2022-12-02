#!/usr/bin/ruby -w

inp = File.new("input.txt","r")

score1 = 0
score2 = 0

# rock paper scissors
# a b c
# x y z
# 1 2 3

#part 2: algebra time?
# a b c
# lose draw win
# 0 3 6
#interesting note: possible scores are integers from 1-9 inc
pt1 = {"A X" => 4,
       "A Y" => 8,
       "A Z" => 3,
       "B X" => 1,
       "B Y" => 5,
       "B Z" => 9,
       "C X" => 7,
       "C Y" => 2,
       "C Z" => 6}

pt2 = {"A X" => 3, #losing means scissors -> 3 pts + 0 loss
       "A Y" => 4,
       "A Z" => 8,
       "B X" => 1, #B-tier scores do not change at all from part 1?
       "B Y" => 5,
       "B Z" => 9,
       "C X" => 2,
       "C Y" => 6,
       "C Z" => 7}

inp.each do |line|
    tmp = line.split("\n")
    score1 += pt1[tmp[0]]
    score2 += pt2[tmp[0]]
end

puts score1
puts score2