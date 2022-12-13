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

    def sort_connections #prioritize connections with the largest height for dfs
        @connections = @connections.sort { |a, b| b.get_height <=> a.get_height}
    end
end

def bfs(graph, epos)
    fifo = []
    visited = []
    distance = Hash.new
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

    return distance, visited
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
epos = []

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
        arr.push(node)
    end
    endpos = raw.index("E")
    if endpos != nil
        epos = [endpos,i]
    end
    map.push(arr)
end

#process map into a (bi)directed graph
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

end_node = map[epos[1]][epos[0]]

closeA = Array.new(1000)
#Breadth-First Search? more like BruteForce Search!
for i in 0..map.size - 1
    for j in 0..map[0].size - 1
        if map[i][j].get_height != 1
            next
        end
        arr, compare = bfs(map,map[i][j])
        if !compare.include?(map[i][j]) || !compare.include?(end_node)
            next
        end
        tst = run_graph(arr,end_node,map[i][j])
        if tst.size < closeA.size
            closeA = tst
        end
    end
end

puts closeA.size #part 2
