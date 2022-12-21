#!/usr/bin/ruby -w

def resolve(stack,dict)
    marked_for_deletion = []
    for i in 0...stack.size
        if stack.size == 0
            break
        end
        if dict[stack[i][1]] != nil && dict[stack[i][3]] != nil
            case stack[i][2]
            when "*"
                dict[stack[i][0]] = dict[stack[i][1]] * dict[stack[i][3]]
            when "+"
                dict[stack[i][0]] = dict[stack[i][1]] + dict[stack[i][3]]
            when "-"
                dict[stack[i][0]] = dict[stack[i][1]] - dict[stack[i][3]]
            when "/"
                dict[stack[i][0]] = dict[stack[i][1]] / dict[stack[i][3]]
            end
            marked_for_deletion.push(i)
        else
            next
        end
    end
    for i in (marked_for_deletion.size-1).downto(0)
        stack.delete_at(marked_for_deletion[i])
    end
    if dict["root"] != nil
        puts dict["root"]
        exit
    end
    return stack, dict
end

input = File.new("input.txt","r")

monkeys = []
shout = {}
waiting = []

input.each do |line|
    raw = line.split(' ')
    arr = [raw[0][0..3]]
    for i in 1...raw.size
        arr.push(raw[i])
    end
    monkeys.push(arr)
end

#print monkeys

root_says = 0
while true
    for i in 0...monkeys.size
        #puts i
        #print monkeys[i]
        if monkeys[i].size == 2 #literal
            shout[monkeys[i][0]] = monkeys[i][1].to_i
        else #put monkey on the waiting stack and try to resolve it and any waiting monkeys
            waiting.unshift(monkeys[i])
            waiting, shout = resolve(waiting,shout)
        end
    end
    if root_says != 0
        break
    end
end
puts "Hello world"