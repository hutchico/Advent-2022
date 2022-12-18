#!/usr/bin/ruby -w

def sa(cube,x,y,z)
    if cube[z][y][x] == nil
        #puts "empty"
        return 0
    end
    count = 0
    if x+1 > cube.size - 1 || cube[z][y][x+1] == nil
        count += 1
    end
    if x-1 < 0 || cube[z][y][x-1] == nil
        count += 1
    end
    if y-1 < 0 || cube[z][y-1][x] == nil 
        count += 1
    end
    if y+1 > cube.size - 1 || cube[z][y+1][x] == nil
        count += 1
    end
    if z-1 < 0 || cube[z-1][y][x] == nil
        count += 1
    end
    if z+1 > cube.size - 1 || cube[z+1][y][x] == nil
        count += 1
    end
    return count
end

input = File.new("input.txt","r")

xarr = []
yarr = []
zarr = []

input.each do |line|
    raw = line.chomp.split(',')
    xarr.push(raw[0].to_i)
    yarr.push(raw[1].to_i)
    zarr.push(raw[2].to_i)
end

#create array based on required values

bound = [(zarr.max-zarr.min).abs,(yarr.max-yarr.min).abs,(xarr.max-xarr.min).abs].max + 2

cube = Array.new(bound) { Array.new(bound) {Array.new(bound)}}


puts cube.size
puts cube[0].size
puts cube[0][0].size

for i in 0...xarr.size
    cube[zarr[i]][yarr[i]][xarr[i]] = '#' #irrelevant what is actually stored
end


count = 0
=begin
for z in 0...cube.size
    for y in 0...cube.size
        for x in 0...cube.size
            count += sa(cube,x,y,z)
        end
    end
end
=end

for i in 0...xarr.size
    count += sa(cube,xarr[i],yarr[i],zarr[i])
end
puts count

puts "Hello world"