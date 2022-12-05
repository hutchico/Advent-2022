#!/usr/bin/ruby -w

def move_crates(total,start,dest)
    #note: start and dest are arrays, not integers
    for i in 1..total
        dest.push(start.last)
        start.pop
    end
end

def print_ship(ship)
    for i in 0..8
        for j in 0..ship[i].size
            print ship[i][j]
            print ' '
        end
        puts
    end
end

input = File.new("input.txt","r")

ship = []
stack = []
for i in 1..9 do
    ship.push(Array.new(stack))
end

while true
    raw = input.readline
    if(raw[0] != '[')
        break
    end
    fptr = 1 #file "pointer" position even though we've already read the entire line once
    for i in 0..8 do
        if(raw[fptr] != ' ')
            ship[i].unshift(raw[fptr])
        end
        fptr += 4
    end
    fptr = 1
end
input.readline #skip whitespace line

input.each do |line|
    move = line.split(' ')
    total = move[1].to_i
    start = move[3].to_i
    dest = move[5].to_i
    move_crates(total,ship[start - 1],ship[dest - 1])
end

#print_ship(ship)

for i in 0..8
    print ship[i].last
end