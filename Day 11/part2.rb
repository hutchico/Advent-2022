#!/usr/bin/ruby -w

class Monkey
    def initialize
        @items = []
        @op = [] #array of an operand and an operator describing action
        @test = 0 #attempt to divide by this number before making testing decision
        @ftarget = 0
        @ttarget = 0
        @worry = 0 # value to % worry
    end

    def give_item(worry)
        @items.push(worry.to_i)
    end

    def assign_op(op)
        @op.push(op)
    end

    def assign_test(num)
        @test = num.to_i
    end

    def assign_false(mky)
        @ftarget = mky
    end

    def assign_true(mky)
        @ttarget = mky
    end

    def assign_worry(val)
        @worry = val
    end

    def has_items?
        return @items.size > 0 ? true : false
    end

    def get_test
        return @test
    end

    def turn
        inspect #transform worry  
        @items[0] %= @worry
        tmp = @items[0]
        toss_item
        if tmp % @test == 0#test worry
            return tmp, @ttarget#pass item
        else
            return tmp, @ftarget
        end
    end

    private

    def inspect
        #multiply worry level of first item
        operand = @op[1] == "old" ? @items[0] : @op[1].to_i
        case @op[0]
        when '+'
            @items[0] += operand
        when '*'
            @items[0] *= operand
        end
    end

    def toss_item
        @items.delete_at(0)
    end
end



input = File.new("input.txt","r")

grp = []


while true
    mky = Monkey.new()
    input.readline
    raw = input.readline.split(" ")
    interest = raw[2..(raw.size-1)]
    for i in 0..interest.size - 1
        mky.give_item(interest[i].to_i)
    end
    raw = input.readline.split(" ")
    for i in 4..5
        mky.assign_op(raw[i])
    end
    raw = input.readline.split(" ")
    mky.assign_test(raw[3])
    raw = input.readline.split(" ")
    mky.assign_true(raw[5])
    raw = input.readline.split(" ")
    mky.assign_false(raw[5])
    grp.push(mky)
    if input.eof?
        break
    end
    input.readline #skip whitespace
end

count_inspects = Array.new(grp.size)
count_inspects.fill(0)

lcm = 1
for i in 0..grp.size - 1
    lcm *= grp[i].get_test
end

for i in 0..grp.size - 1
   grp[i].assign_worry(lcm)
end

for _ in 1..10000 #part 2
    for i in 0..grp.size - 1
        while grp[i].has_items?
            #process first item in list until no more items
            item, target = grp[i].turn
            grp[target.to_i].give_item(item.to_i)
            count_inspects[i] += 1
        end
    end
end

count_inspects = count_inspects.sort { |a, b| b <=> a}

puts count_inspects[0] * count_inspects[1]