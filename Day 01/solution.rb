#!/usr/bin/ruby -w

input = File.new("input", "r")

mcal = -1
cur = 0
totals = []

input.each do |line|
    if line != "\n" 
        cur += line.to_i
        next
    end
    totals.push(cur) #part 2
    if cur > mcal
        mcal = cur #part 1
    end
    cur = 0
end

totals = totals.sort { |a, b| b <=> a}

puts mcal #part 1

puts totals[0] + totals[1] + totals[2] #part 2