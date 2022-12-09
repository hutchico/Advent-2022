#!/usr/bin/ruby -w

RT2 = Math.sqrt(2)
RT5 = Math.sqrt(5)
RT8 = Math.sqrt(8)

class Rope
    def initialize 
        @knots = [] #array recording positions of knots
        @grid = Hash.new #collection of unique indices where Tail knot has been present
        
        for i in 0..9 
            @knots[i] = [0,0]
        end
        #each Rope has ten knots -> head, 8x subknots, tail
        add_hash #record initial tail position
    end

    def move_knots(i) #internal method called every time the head is moved somewhere
        #two different actions depending on if px == tx and/or py == ty?
        
        posx = @knots[i-1][0] 
        posy = @knots[i-1][1] 
        tx = @knots[i][0]
        ty = @knots[i][1]
        
        case get_dist(i-1,i)
        when 0..RT2 #head is still within acceptable range
            return
        when 2 #vertical or horizontal movement needed
            if(posx - tx > 0) #right
                tx += 1
            elsif(posy - ty > 0) #up
                ty += 1
            elsif(posx - tx < 0) #left
                tx -= 1
            else #posy - ty < 0
                ty -= 1
            end
        when RT5..RT8 #diagonal movement
            if(posx - tx > 0 && posy - ty > 0) #up right
                tx += 1
                ty += 1
            elsif(posx - tx < 0 && posy - ty > 0) #up left
                tx -= 1
                ty += 1
            elsif(posx - tx < 0 && posy - ty < 0) #down left
                tx -= 1
                ty -= 1
            else #down right
                tx += 1
                ty -= 1
            end
        end
        @knots[i][0] = tx
        @knots[i][1] = ty
    end

    def get_dist(index1,index2) #helper function to find euclidean distance between two knots
        return Math.sqrt((@knots[index1][0] - @knots[index2][0])**2 + (@knots[index1][1] - @knots[index2][1])**2)
    end

    def add_hash
        x = @knots[9][0]
        y = @knots[9][1]
        arr = [x,y]
        if(@grid[arr] != nil)
            @grid[arr] += 1
        else
            @grid[arr] = 1
        end
    end

    def translate_motion #move the rest of the rope to match head motion
        for i in 1..9
            move_knots(i)
        end
        add_hash
    end

    def move(dir, dist)
        case dir
        when 'R'
            for i in 1..dist
                @knots[0][0] += 1
                translate_motion
            end
        when 'L'
            for i in 1..dist
                @knots[0][0] -= 1
                translate_motion
            end
        when 'U'
            for i in 1..dist
                @knots[0][1] += 1
                translate_motion
            end
        when 'D'
            for i in 1..dist
                @knots[0][1] -= 1
                translate_motion
            end
        end
    end

    def geth
        return @grid.size
    end

end

input = File.new("input.txt","r")

knot = Rope.new

input.each do |command|
    line = command.split(" ")
    knot.move(line[0],line[1].to_i)
end

puts knot.geth