#!/usr/bin/ruby -w

class Grain
    def initialize
        @xcoord = 500
        @ycoord = 0
    end

    def to_s
        "o" #vis aid
    end

    def getx
        return @xcoord
    end

    def gety
        return @ycoord
    end

    def can_move?(grid) #test if this should be at rest
        return open_down?(grid) || open_left?(grid) || open_right?(grid) ? true : false
    end

    def move(grid)
        grid[@ycoord][@xcoord] = '.'
        if open_down?(grid)
            #do_nothing
        elsif open_left?(grid) 
            @xcoord -= 1
        elsif open_right?(grid)
            @xcoord += 1
        end
        @ycoord += 1
        grid[@ycoord][@xcoord] = self
    end

    private
    def open_down?(grid)
        return grid[@ycoord+1][@xcoord] == '.' ? true : false
    end

    def open_left?(grid)
        return grid[@ycoord+1][@xcoord-1] == '.' ? true : false
    end

    def open_right?(grid)
        return grid[@ycoord+1][@xcoord+1] == '.' ? true : false
    end

end

def drop_sand(grid)
    count = 0
    while true #oh the horror
        sand = Grain.new
        count += 1
        grid[0][500] = sand
        while true
            if sand.gety == $window_maxy
                break
            end
            if sand.can_move?(grid)
                sand.move(grid)
            else
                break
            end
        end
        if sand.gety == $window_maxy
            break
        end
    end
    return count - 1 #except the last grain that was used to trigger breaks
end

def draw_line(grid,pt1,pt2)
    if pt1[0] - pt2[0] == 0 #vertical line
        lower = pt1[1] < pt2[1] ? pt1[1] : pt2[1] #to make range notation work
        upper = pt1[1] < pt2[1] ? pt2[1] : pt1[1]
        for i in lower..upper
            grid[i][pt1[0]] = '#'
        end
    else #horizontal line
        lower = pt1[0] < pt2[0] ? pt1[0] : pt2[0] #to make range notation work
        upper = pt1[0] < pt2[0] ? pt2[0] : pt1[0]
        for i in lower..upper
            grid[pt1[1]][i] = '#'
        end
    end
end
#DEBUG
def draw_grid(grid)
    for i in $window_miny..$window_maxy#for i in 0..grid.size - 1
        for j in $window_minx - 3..$window_maxx + 3#for j in 0..grid[0].size - 1
            print grid[i][j]
        end
    puts ''
    end
end

input = File.new("input.txt","r")

grid = Array.new(200) { Array.new(1000) }

for i in 0..grid.size - 1
    grid[i].fill('.')
end

grid[0][500] = 'S'

$window_minx = 1000 #global variables tracking printing window for visual verification
$window_maxx = 0
$window_miny = 0
$window_maxy = -1 #exit condition for part 1

input.each do |line|
    line = line.delete("\n")
    raw = line.split(" -> ")
    for i in 0...raw.size - 1
        pt1 = raw[i].split(',')
        pt1[0] = pt1[0].to_i
        pt1[1] = pt1[1].to_i
        pt2 = raw[i+1].split(',')
        pt2[0] = pt2[0].to_i
        pt2[1] = pt2[1].to_i
        if pt1[0] < $window_minx || pt2[0] < $window_minx
            $window_minx = pt1[0] < pt2[0] ? pt1[0] : pt2[0] #DEBUG
        end
        if pt1[0] > $window_maxx || pt2[0] > $window_maxx
            $window_maxx = pt1[0] < pt2[0] ? pt1[0] : pt2[0] #DEBUG
        end

        if pt1[1] > $window_maxy || pt2[1] > $window_maxy
            $window_maxy = pt1[1] > pt2[1] ? pt1[1] : pt2[1]
        end

        draw_line(grid,pt1,pt2)
    end
end

count = drop_sand(grid)

puts count