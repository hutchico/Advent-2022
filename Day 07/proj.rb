#!/usr/bin/ruby -w

class Node 
    def initialize(name)
        @name = name
        @size = nil
        @children = []
    end

    def getn()
        return @name
    end

    def setn(name)
        @name = name
    end

    def sets(size)
        @size = size
    end

    def add_child(child)
        @children.push(child)
    end

    def count_children()
        return @children.size
    end

    def getc(index)
        #assert_not_nil(@children[index])
        return @children[index]
    end

    def sum_dir()
        if @children.size == 0 #this is a file not a directory
            return @size
        end
        total = 0
        for i in 0..@children.size - 1
            total += @children[i].sum_dir
        end
        return total
    end

end

def explore(tree,file)
    while true
        if file.eof?
            break
        end
        line = file.readline
        line = line.split(' ')
        fresh_node = Node.new("null")
        if line[0] == "$"
            if line[1] == "cd"
                if line[2] == ".." #back up one level
                    return
                else #iterate through tree until we find the aforementioned directory
                    for i in 0..tree.count_children - 1
                        if tree.getc(i).getn == line[2]
                            explore(tree.getc(i),file)
                            break
                        end
                    end
                    next
                end
            else #ls
                next
            end
        elsif line[0] == "dir"
            fresh_node.setn(line[1])
        else
            fresh_node.sets(line[0].to_i)
            fresh_node.setn(line[1])
        end
        tree.add_child(fresh_node)
    end
end

def size_dirs(tree)
    per = 0
    this_dir_count = 0
    for i in 0..tree.count_children - 1 #sum together everything in this directory (files and subdirectories alike)
        per += tree.getc(i).sum_dir
        if per > 100000 #short circuit
            break
        end
    end
    if per < 100000
        this_dir_count = per
    end
    for i in 0..tree.count_children - 1 #do the same for all this directory's children
        this_dir_count += size_dirs(tree.getc(i))
    end
    return this_dir_count
end

def find_dir(tree,target,smallest)
    if tree.count_children == 0
        return smallest
    end
    per = tree.sum_dir
    if per > target
        if per < smallest
            smallest = per
        end
        for i in 0..tree.count_children - 1
            ret = find_dir(tree.getc(i),target,smallest)
            if ret < smallest
                smallest = ret
            end
        end
    end
    return smallest
end

input = File.new("input.txt","r")

tree = Node.new("/")
input.readline #skip root command

explore(tree,input)

puts size_dirs(tree)

to_del = 30000000 - (70000000 - tree.sum_dir)

#puts "Target directory size: #{to_del}"

puts find_dir(tree,to_del,70000000) #third arg is an arbitrary large number

#specific numbers:
#total space: 70000000
#needed?      30000000