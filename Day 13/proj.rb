#!/usr/bin/ruby -w

def mergesort(arr) #damn you and your finnicky .sort function for making me do actual work
    if arr.size <= 1
        return arr
    else
        middle = arr.size / 2
        half1 = mergesort(arr[0...middle])
        half2 = mergesort(arr[middle...arr.size])
        merge(half1,half2)
    end
end

def merge(left, right)
    arr = []

    while !left.empty? && !right.empty?
        bool = compare_lists(left[0],right[0])
        if bool
            arr.push(left.shift)
        else
            arr.push(right.shift)
        end
    end
    return arr + left + right
end

def parse(file)
    arr = file.readline.split(//)
    if arr.last == '\n'
        arr.pop #clear newline
    end
    arr.shift #clear '['
    return make_arr(arr)
end

def make_arr(args)
    li = []
    while args.size != 0
        case args[0]
        when '['
            args.shift
            li.push(make_arr(args))
        when ','
            args.shift
            next
        when ']'
            args.shift
            return li
        else
            val = args[0].to_i
            if args[0] == "1" && args[1] == "0" #hardcoding 10 b/c it's the only 2-digit number
                val = (args[0].to_i * 10) + args[1].to_i
                args.shift
            end
            li.push(val)
            args.shift
        end
    end
end

def compare_lists(li1, li2)

    size = li1.size < li2.size ? li2.size : li1.size #use larger array for size bounding

    for i in 0..size - 1
        if li2[i] == nil #second array runs out of arguments first
            return false
        elsif li1[i] == nil
            return true
        end

        if li1[i].is_a?(Integer) && li2[i].is_a?(Integer)
            if li1[i] == li2[i]
                next
            else
                return li1[i] < li2[i] ? true : false
            end
        elsif li1[i].is_a?(Array) && li2[i].is_a?(Array)
            if li1[i] == li2[i]
                next
            else
                return compare_lists(li1[i],li2[i])
            end
        else
            arr = []
            if li1[i].is_a?(Integer) #implies li2[i] is an array
                arr.push(li1[i])
                val = compare_lists(arr,li2[i])
                if val == nil #workaround for integer == integer result
                    next
                end
                return val
            else #li2[i].is_a?(Integer)
                arr.push(li2[i])
                val = compare_lists(li1[i],arr)
                if val == nil
                    next
                end
                return val
            end
        end
    end
    return nil
end

input = File.new("input.txt","r")

pkts = []

while true
    pkts.push(parse(input))
    pkts.push(parse(input))
    if input.eof?
        break
    end
    input.readline #chew up blank line
end

right = 0

#process inputs
for i in (0..pkts.size-1).step(2)
    val = compare_lists(pkts[i],pkts[i+1]) ? 1 : 0
    right += val * ((i/2) + 1)
end
puts right

pkts.push([[2]])
pkts.push([[6]])

pkts = mergesort(pkts)

div2 = 0
div6 = 0
for i in 0..pkts.size - 1
    if pkts[i] == [[2]]
        div2 = i + 1
    end
    if pkts[i] == [[6]]
        div6 = i + 1
        break
    end
end

puts div2 * div6