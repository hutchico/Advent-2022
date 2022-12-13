#!/usr/bin/ruby -w

class Node
    def initialize
        @connections = []
        @height = nil
        @x = nil
        @y = nil
    end

    def add_conn(toAdd)
        @connections.push(toAdd)
        sort_connections
    end

    def set_height(hgt)
        @height = hgt
    end

    def setx(x)
        @x = x
    end

    def sety(y)
        @y = y
    end

    def getx
        return @x
    end

    def gety
        return @y
    end

    def get_height
        return @height
    end

    def get_conns
        return @connections
    end

    private

    def sort_connections #prioritize connections with the largest height for bfs
        @connections = @connections.sort { |a, b| b.get_height <=> a.get_height}
    end
end

def print_arr(arr)
    for i in 0..arr.size - 1
        for j in 0..arr[0].size - 1
            print arr[i][j]
        end
        puts ''
    end
end

def bfs(graph, epos)
    fifo = []
    visited = []
    distance = {}
    visited.push(epos)
    fifo.push(epos)
    while !fifo.empty?
        cur = fifo.shift
        nodes = cur.get_conns
        nodes.each do |node|
            if visited.include?(node)
                next
            end
            fifo.push(node)
            visited.push(node)
            distance[node] = cur
        end
    end

    return distance
end

def run_graph(distances,dest,start)
    path = []

    while dest != start
        path.unshift(dest)
        dest = distances[dest]
    end

    return path
end



input = File.new("input.txt","r")

map = []

dists = []
spos = [] #coordinates of start position
epos = []
nodelist = []

for i in 0..10000 #arbitrary large number
    if input.eof?
        break
    end
    raw = input.readline
    if raw[0] == "" || raw[0] == "\n"
        break
    end
    raw = raw.split(//)
    raw.pop
    arr = []
    inf = []
    vis = []
    for n in 0..raw.size - 1
        node = Node.new
        hgt = raw[n].chr.ord - 96
        case hgt
        when -27
            hgt = 26 #goal
        when -13
            hgt = 1
        end
        node.set_height(hgt)
        node.setx(n)
        node.sety(i)
        inf.push(2**32)
        arr.push(node)
        vis.push(".")
    end
    pos = raw.index("S")
    if pos != nil
        spos = [pos,i]
    end
    endpos = raw.index("E")
    if endpos != nil
        epos = [endpos,i]
    end
    dists.push(inf)
    map.push(arr)
    nodelist.push(vis)
end

#process map into a directed graph
for y in 0..map.size - 1
    for x in 0..map[0].size - 1
        hgt = map[y][x].get_height
        if x > 0
            if map[y][x-1].get_height <= hgt + 1
                map[y][x].add_conn(map[y][x-1])
            end
        end
        if x < map[0].size - 1
            if map[y][x+1].get_height <= hgt + 1
                map[y][x].add_conn(map[y][x+1])
            end
        end
        if y > 0
            if map[y-1][x].get_height <= hgt + 1
                map[y][x].add_conn(map[y-1][x])
            end
        end
        if y < map.size - 1
            if map[y+1][x].get_height <= hgt + 1
                map[y][x].add_conn(map[y+1][x])
            end
        end
    end
end

start_node = map[spos[1]][spos[0]]
end_node = map[epos[1]][epos[0]]

arr = bfs(map,start_node)

arr = run_graph(arr,end_node,start_node)

puts arr.size #part 1

exit

#visualization function
for i in 0..arr.size - 1
    cord = arr[i]
    puts "#{cord.getx},#{cord.gety}"
    nodelist[cord.gety][cord.getx] = "#"
end
print_arr(nodelist)
