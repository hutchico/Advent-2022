#!/usr/bin/ruby -w

class Node
    def initialize(name,op,names,value)
        @name = name
        @op = op
        @children = []
        if names != nil
            @child_names = [names[0],names[1]]
        else
            @child_names = nil
        end
        @value = value #may be nil if this is not a number
    end

    def add_child(child)
        @children.push(child)
    end

    def getnames
        return @child_names
    end

    def name
        return @name
    end

    def op
        return @op
    end

    def set_op(op)
        @op = op
    end

    def value
        return @value
    end

    def set_val(val)
        @value = val
    end
    
    def get_cvals #DEBUG
        puts @children[0].screech - @children[1].screech
    end

    def screech() #resolve this monkey's equation
        if @value != nil
            return @value
        end
        case @op
        when "*"
            return @children[0].screech * @children[1].screech
        when "+"
            return @children[0].screech + @children[1].screech
        when "-"
            return @children[0].screech - @children[1].screech
        when "/"
            return @children[0].screech / @children[1].screech
        when "="
            return @children[0].screech == @children[1].screech ? true : false
        end
    end
end

input = File.new("input.txt","r")

monkeys = []

input.each do |line|
    raw = line.split(' ')
    name = raw[0][0..3]
    if raw.size == 2 #num
        mk = Node.new(name,nil,nil,raw[1].to_i)
    else
        mk = Node.new(name,raw[2],[raw[1],raw[3]],nil)
    end
    monkeys.push(mk)
end

rt = monkeys.index { |n| n.name == "root"}
monkeys[rt].set_op("=")
hm = monkeys.index { |n| n.name == "humn"}

for i in 0...monkeys.size #populate each monkey with actual links to child monkey
    if monkeys[i].value != nil
        next
    end
    targets = monkeys[i].getnames
    for nm in 0...targets.size
        ind = monkeys.index { |n| n.name == targets[nm]}
        monkeys[i].add_child(monkeys[ind])
    end
end

monkeys[hm].set_val(3221245800000) #hardcode guess based on tested values to cut down on bruteforce time

while true
    monkeys[hm].set_val(monkeys[hm].value + 1)
    trigger = monkeys[rt].screech
    if trigger
        break
    end
end

puts monkeys[hm].value