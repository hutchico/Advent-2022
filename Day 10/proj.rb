#!/usr/bin/ruby -w

input = File.new("input.txt","r")

reg = 1
cycles = 0

screen = Array.new(240)
screen.fill(' ')
values = [1] #track value of reg during each cycle

while true
    if input.eof?
        break
    end
    command = input.readline.split(" ")
    if command[0] == "noop"
        if ((reg-1)..(reg+1)).cover?(cycles % 40)
            screen[cycles] = '#'
        end
        cycles += 1
        values.push(reg)
        next
    end

    for i in 1..2 #addx
        if ((reg-1)..(reg+1)).cover?(cycles % 40)
            screen[cycles] = '#'
        end
        cycles += 1
        if i == 2
            reg += command[1].to_i
        end
        values.push(reg)
    end
end

puts 20 * values[19] + 60 * values[59] + 100 * values[99] + 140 * values[139] + 180 * values[179] + 220 * values[219]

for i in 0..5
    for j in 0..39
        print screen[(i * 40) + j]
    end
    puts ''
end