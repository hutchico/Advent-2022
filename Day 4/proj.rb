#!/usr/bin/ruby -w

def test_overlap(range1,range2)
    #return 1 if sections overlap, otherwise 0
#    if(range1.min <= range2.min && range1.max >= range2.max) #part 1
    if(range1.member?(range2.min) || range1.member?(range2.max))  #part 2: two cases, overlap on left edge and overlap on right edge
        return 1
    else
        return 0
    end
end

input = File.new("input.txt","r")

overlaps = 0

input.each do |line|
    pair = line.split(',')
    elf1 = pair[0].split('-')
    elf2 = pair[1].split('-')
    elf1 = elf1[0]..elf1[1]#Range.new(Integer(elf1[0]),Integer(elf1[1]))
    elf2 = elf2[0]..elf2[1]#Range.new(Integer(elf2[0]),Integer(elf2[1]))
    bigger = elf1.size > elf2.size ? true : false #is elf1 larger than elf2
    if(bigger) #always compare larger section to smaller one
        overlaps += test_overlap(elf1,elf2)
    else
        overlaps += test_overlap(elf2,elf1)
    end
end

puts overlaps