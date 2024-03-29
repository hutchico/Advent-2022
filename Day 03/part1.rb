#!/usr/bin/ruby -w

input = File.new("input.txt","r")

prio = 0

input.each do |line|
    comp_1 = line[0..line.length / 2 - 1]
    comp_2 = line[line.length / 2..line.length]
    li = comp_1.split(//)
#prio -> a-z 1-26 => ascii values 97-122
#        A-Z 27-52                65-90    
    li.each do |arr|
        if comp_2.index(arr) != nil
            val = arr.ord
            if val > 90
                val -= 96
            else
                val -= 38
            end
            prio += val
            break #exactly one commonality between the two halves
        end
    end
end

puts prio
