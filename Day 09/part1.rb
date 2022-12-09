#!/usr/bin/ruby -w

RT2 = Math.sqrt(2)
RT5 = Math.sqrt(5)

class Rope
    def initialize 
        @posx = 0 #position of head in a 2D grid space
        @posy = 0
        @tx = 0 #position of tail relative to head's location
        @ty = 0
        @grid = Hash.new #collection of unique indices where Tail has been present
        add_hash #record initial tail position
    end

    def update_tail #internal method called every time the head is moved somewhere
        #two different actions depending on if px == tx and/or py == ty?
        case get_dist
        when 0..RT2 #head is still within acceptable range
            return
        when 2 #vertical or horizontal movement needed
            if(@posx - @tx > 0) #right
                @tx += 1
                add_hash
            elsif(@posy - @ty > 0) #up
                @ty += 1
                add_hash
            elsif(@posx - @tx < 0) #left
                @tx -= 1
                add_hash
            else #posy - ty < 0
                @ty -= 1
                add_hash
            end
        when RT5 #diagonal movement
            if(@posx - @tx > 0 && @posy - @ty > 0) #up right
                @tx += 1
                @ty += 1
            elsif(@posx - @tx < 0 && @posy - @ty > 0) #up left
                @tx -= 1
                @ty += 1
            elsif(@posx - @tx < 0 && @posy - @ty < 0) #down left
                @tx -= 1
                @ty -= 1
            else #down right
                @tx += 1
                @ty -= 1
            end
        end
        add_hash
    end

    def get_dist #helper function to find euclidean distance between head and tail
        return Math.sqrt((@posx - @tx)**2 + (@posy - @ty)**2)
    end

    def add_hash
        arr = [@tx,@ty]
        if(@grid[arr] != nil)
            @grid[arr] += 1
        else
            @grid[arr] = 1
        end
    end

    def move(dir, dist)
        case dir
        when 'R'
            for i in 1..dist
                @posx += 1
                update_tail
            end
        when 'L'
            for i in 1..dist
                @posx -= 1
                update_tail
            end
        when 'U'
            for i in 1..dist
                @posy += 1
                update_tail
            end
        when 'D'
            for i in 1..dist
                @posy -= 1
                update_tail
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