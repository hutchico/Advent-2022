#!/usr/bin/ruby -w

def part1(range1,range2)
    #return 1 if sections overlap, otherwise 0
    if(range1.min <= range2.min && range1.max >= range2.max) #part 1
        return 1
    else
        return 0
    end
end

def part2(range1,range2)
    #return 1 if sections overlap, otherwise 0
    if(range1.member?(range2.min) || range1.member?(range2.max)) #part 2: two cases, overlap on left edge and overlap on right edge
        return 1
    else
        return 0
    end
end

input = File.new("input.txt","r")

overlaps1 = 0
overlaps2 = 0

input.each do |line|
    pair = line.split(',')
    elf1 = pair[0].split('-')
    elf2 = pair[1].split('-')
    elf1 = Range.new(Integer(elf1[0]),Integer(elf1[1]))
    elf2 = Range.new(Integer(elf2[0]),Integer(elf2[1]))
    bigger = elf1.size > elf2.size ? true : false #is elf1 larger than elf2
    if(bigger) #always compare larger section to smaller one
        overlaps1 += part1(elf1,elf2)
        overlaps2 += part2(elf1,elf2)
    else
        overlaps1 += part1(elf2,elf1)
        overlaps2 += part2(elf2,elf1)
    end
end

puts overlaps1
puts overlaps2