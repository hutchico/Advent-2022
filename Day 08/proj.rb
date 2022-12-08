#!/usr/bin/ruby -w

#todo: sort this garbage out, wasted a ton of time trying to do too much with one function
def chk_up(map,height,x,y)
    if(y == 0)
        return -1
    end
    count = 0
    for i in 0..y-1
        if map[i][x].to_i >= height
            return count
        end
        count += 1
    end
    return count
end

def chk_dwn(map,height,x,y) # map 5 2 1
    if(y == map.size - 1)
        return -1
    end
    count = 0
    for i in y + 1..map.size - 1 # 2..4
        if map[i][x].to_i >= height
            return count
        end
        count += 1
    end
    return count
end

def chk_lft(map,height,x,y)
    if(x == 0)
        return -1
    end
    count = 0
    for i in 0..x - 1
        if map[y][i].to_i >= height
            return count
        end
        count += 1
    end
    return count
end

def chk_rgt(map,height,x,y)
    if(x == map[0].size - 1)
        return -1
    end
    count = 0
    for i in x + 1..map[0].size - 1
        if map[y][i].to_i >= height
            break
        end
        count += 1
    end
    return count
end

#yeah screw this I'm done trying to make one function fit two purposes

def count_up(map,height,x,y)
    if (y == 0)
        return 0
    end
    count = 0
    while true
        count += 1
        if(map[y-count][x].to_i >= height || y-count == 0)
            break
        end
    end
    return count
end

def count_down(map,height,x,y)
    if(y == map.size - 1)
        return 0
    end
    count = 0
    while true
        count += 1
        if(map[y+count][x].to_i >= height || y+count == map.size - 1)
            break
        end
    end
    return count
end

def count_left(map,height,x,y)
    if (x == 0)
        return 0
    end
    count = 0
    while true
        count += 1
        if(map[y][x-count].to_i >= height || x-count == 0)
            break
        end
    end
    return count
end

def count_rght(map,height,x,y)
    if (x == map[0].size - 1)
        return 0
    end
    count = 0
    while true
        count += 1
        if(map[y][x+count].to_i >= height || x+count == map[0].size - 1)
            break
        end
    end
    return count
end

input = File.new("input.txt","r")

treemap = []

input.each do |line|
    tmp = line.split(//)
    tmp.pop #remove newline character
    treemap.push(tmp)
end

visible = 0

for i in 0..treemap.size - 1
    for j in 0..treemap[0].size - 1
        #puts "#{j}, #{i}, @#{treemap[i][j]}"
        if (i == 0 || i == treemap.size - 1) || (j == 0 || j == treemap[0].size - 1)
            visible += 1
            #puts "yes"
            next
        end
        if(chk_up(treemap,treemap[i][j].to_i,j,i) == i || 
          chk_dwn(treemap,treemap[i][j].to_i,j,i) == treemap.size - i - 1||
          chk_lft(treemap,treemap[i][j].to_i,j,i) == j ||
          chk_rgt(treemap,treemap[i][j].to_i,j,i) == treemap[0].size - j - 1)
            #puts "yesh"
            visible += 1
        end
    end
end
            
puts visible

score = 0
for i in 0..treemap.size - 1
    for j in 0..treemap[0].size - 1
        #puts "#{j}, #{i}, @#{treemap[i][j]}"
        n =   count_up(treemap,treemap[i][j].to_i,j,i)
        w = count_left(treemap,treemap[i][j].to_i,j,i)
        s = count_down(treemap,treemap[i][j].to_i,j,i)
        e = count_rght(treemap,treemap[i][j].to_i,j,i)
        #puts "#{n} #{w} #{s} #{e}"
        tmp = n * w * s * e
        #puts tmp
        if tmp > score
            score = tmp
            #puts "new score #{tmp} at #{j},#{i}"
        end
    end
end

puts score