#!/usr/bin/ruby -w

class Sensor
    def initialize(x,y,bx,by,line)
        @xcoord = x
        @ycoord = y
        @beaconx = bx
        @beacony = by
        @mdist = (x - bx).abs + (y - by).abs #distance to beacon
        dev = (@mdist - (@ycoord - line).abs).abs
        @range = (@xcoord - dev)..(@xcoord + dev) #range of values for y = line where there is no beacon
    end

    def get_mdist
        return @mdist
    end

    def contains?(x,y) #does point (x,y) fall within this sensor's exclusion zone?
        return (@xcoord - x).abs + (@ycoord - y).abs <= @mdist ? true : false
    end

    def get_xcoord
        return @xcoord
    end

    def get_ycoord
        return @ycoord
    end

    def get_bx
        return @beaconx
    end

    def get_by
        return @beacony
    end

    def get_range
        return @range
    end

    def find_ptsy(x,mdist) #get y endpoints for a certain x value and mdist
        dev = (mdist - (@xcoord - x).abs).abs
        return @ycoord - dev, @ycoord + dev
    end
end

input = File.new("input.txt","r")
testy = 2000000
tr = 0..4000000 #test range ie 0-20 or 0-4000000



pack = []
ranges = []
beacons_in_range = []

input.each do |line|
    raw = line.split(' ')
    raw = [raw[2],raw[3],raw[8],raw[9]]
    raw[0] = raw[0][2...raw[0].size] #x=
    cpos = raw[0].index(',')
    raw[0] = raw[0][0...cpos]

    raw[1] = raw[1][2...raw[1].size] #y=
    cpos = raw[1].index(':')
    raw[1] = raw[1][0...cpos]

    raw[2] = raw[2][2..raw[2].size] #x=
    cpos = raw[2].index(',')
    raw[2] = raw[2][0...cpos]

    raw[3] = raw[3][2...raw[3].size]
    cpos = raw[3].index('\n') #newline this time
    raw[3] = raw[3][0...cpos]
    
    s = Sensor.new(raw[0].to_i,raw[1].to_i,raw[2].to_i,raw[3].to_i,testy)
    pack.push(s)
end

#find largest x coord
right = -1
left = 2**32
for i in 0...pack.size
    ranges.push(pack[i].get_range)
    candx = pack[i].get_xcoord
    candbx = pack[i].get_bx
    dev = pack[i].get_mdist
    if candx > right
        right = candx
        right += dev
    elsif candbx > right
        right = candbx
        right += dev
    end
    #find lefthand bound as well
    if candx < left
        left = candx
        left -= dev
    elsif candbx < left
        left = candbx
        left -= dev
    end

    if pack[i].get_by == testy
        beacons_in_range.push(pack[i].get_bx)
    end
end

#TODO: figure out why part 1 doesn't work if you don't arbitrarily increase search range
left -= 1000000 
right += 1000000

count = 0
for i in left..right
    for j in 0...ranges.size
        if ranges[j].cover?(i)
            count += 1
            break
        end
    end
    if beacons_in_range.include?(i)
        count -= 1
    end
end
puts count

#part 2
for k in 0...pack.size
    targ = pack[k].get_mdist + 1
    for n in (pack[k].get_xcoord - targ)..(pack[k].get_xcoord + targ)
        trigger1 = false
        trigger2 = false
        negy, posy = pack[k].find_ptsy(n,targ)
        for u in 0...pack.size
            if trigger1 && trigger2
                break
            end
            if pack[u].contains?(n,negy)
                trigger1 = true
            end
            if pack[u].contains?(n,posy)
                trigger2 = true
            end
        end
        if trigger1 == false && tr.cover?(n) && tr.cover?(negy)
            puts (4000000 * n) + negy
            exit #eh screw it don't bother finishing or breaking, we got what we came for
        elsif trigger2 == false && tr.cover?(n) && tr.cover?(posy)
            puts (4000000 * n) + posy
            exit
        end
    end
end

