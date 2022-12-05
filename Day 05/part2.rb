#!/usr/bin/ruby -w

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
    start = move[3].to_i - 1 #stack label => array label
    dest = move[5].to_i - 1
    
    middle = ship[start].size - total #get index value to start copying at

    ship[dest] = ship[dest] + ship[start][middle,ship[start].size]

    ship[start] = ship[start][0,middle]
end

for i in 0..8
    print ship[i].last #top of every "stack"
end