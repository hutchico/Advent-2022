#!/usr/bin/ruby -w

input = File.new("input", "r")

cur = 0
totals = Array.new

input.each do |line|
    if line != "\n" 
        cur += line.to_i
        #puts line
        next
    end
    totals.push(cur)
    cur = 0
end

totals = totals.sort { |a, b| b <=> a}

puts totals[0] + totals[1] + totals[2]


