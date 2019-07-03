require "set"

class GraphNode
    attr_reader :value
    attr_accessor :neighbors

    def initialize(value)
        @value = value
        @neighbors = []
    end

    def add_node(node)
        self.neighbors << node
    end

    

    def bfs(starting_node, target_val)
        queue = [starting_node]
        visited = Set.new()
        
        while !queue.empty? 
            next_node = queue.shift
            unless visited.include?(next_node)
                return next_node.value if next_node.value == target_val
                visited.add(next_node)
                queue += next_node.neighbors
            end
        end
        nil
    end
end

a = GraphNode.new('a')
b = GraphNode.new('b')
c = GraphNode.new('c')
d = GraphNode.new('d')
e = GraphNode.new('e')
f = GraphNode.new('f')
a.neighbors = [b, c, e]
c.neighbors = [b, d]
e.neighbors = [a]
f.neighbors = [e]

p a.bfs(a, "f")