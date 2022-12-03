#!/usr/bin/ruby -w

input = File.new("input.txt","r")

prio = 0

while 1 == 1 # while TRUE?
    if input.eof?
        break
    end
    comp_1 = input.readline
    comp_2 = input.readline
    comp_3 = input.readline

    li = comp_1.split(//)
    li.each do |b|
        if comp_2.index(b) != nil && comp_3.index(b) != nil
            val = b.ord
            if val > 90
                val -= 96
            else
                val -= 38
            end
            prio += val
            break
        end
    end
end

puts prio