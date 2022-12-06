#!/usr/bin/ruby -w

def test_repeats(arr)
    list = [arr[0]]
    for i in 1..3
        if(list.include?(arr[i]))
            return false
        else
            list.push(arr[i])
        end
    end
    return true
end

input = File.new("input.txt","r")

raw = input.readline.split(//)
ptr = 0
tracker = raw[0..3]
print tracker

while true
    tracker.push(raw[0])
    tracker.delete_at(0)
    raw.delete_at(0)
    ptr = ptr + 1
    if(test_repeats(tracker)) #test all 4 characters are unique
        break
    end
end

print tracker
puts ptr