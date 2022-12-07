#!/usr/bin/ruby -w

def test_repeats(arr)
    for i in 0..arr.size-1
        if(arr.count(arr[i]) > 1)
            return false
        end
    end
    return true
end

input = File.new("input.txt","r")

raw = input.readline.split(//)
ptr = 14
tracker = raw[0..13]

while true
    tracker.push(raw[ptr])
    tracker.delete_at(0)
    ptr += 1
    if(test_repeats(tracker)) #test all 14 characters are unique
        break
    end
end

puts ptr