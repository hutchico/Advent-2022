#!/usr/bin/ruby -w

input = File.new("input", "r")

mcal = -1
cur = 0

input.each do |line|
    if line != "\n" 
        cur += line.to_i
        next
    end
    if cur > mcal
        mcal = cur
    end
    cur = 0
end

puts mcal