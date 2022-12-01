#!/usr/bin/ruby -w

input = File.new("input", "r")

elf = 1
mcal = -1
cur = 0

input.each do |line|
    if line != "\n" 
        cur += line.to_i
        #puts line
        next
    end
    if cur > mcal
        mcal = cur
        puts mcal
    end
    cur = 0
end

puts mcal


