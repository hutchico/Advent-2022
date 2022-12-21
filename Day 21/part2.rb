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
            when "="
                puts "#{dict[stack[i][1]]} - #{dict[stack[i][3]]}"
                if dict[stack[i][1]] == dict[stack[i][3]]
                    print true
                    puts ''
                    print dict["humn"]
                    puts ''
                    exit
                end
                dict["root"] = 0
            end
        else
            next
        end
    end
    return stack, dict
end

input = File.new("input.txt","r")

monkeys = []
shout = {}
links = []

input.each do |line|
    raw = line.split(' ')
    arr = [raw[0][0..3]]
    for i in 1...raw.size
        arr.push(raw[i])
    end
    monkeys.push(arr)
end

rt = monkeys.index { |n| n[0] == "root"}
monkeys[rt][2] = "="
hm = monkeys.index { |n| n[0] == "humn"}
monkeys[hm][1] = -1
#print monkeys
while true
    while true
        monkeys[hm][1] += 1
        for i in 0...monkeys.size
            if monkeys[i].size == 2 #literal
                shout[monkeys[i][0]] = monkeys[i][1].to_i
            else #put monkey on the waiting stack and try to resolve it and any waiting monkeys
                links.unshift(monkeys[i])
                links, shout = resolve(links,shout)
            end
            if shout["root"] != nil
                break
            end
        end
        if shout["root"] != nil
            break
        end
    end
    shout.clear
    links.clear
end




puts "Hello world"