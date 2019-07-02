class GraphNode
    attr_reader :value
    attr_accessor :neighbors
    def initialize(val)
        @value = val
        @neighbors = []
    end

    def inspect
        {'value' => @value}.inspect
    end

end

def bfs(starting_node, target_value)
    q = [starting_node]
    seen = []
    while !q.empty?
        node = q.shift
        seen << node
        return node if node.value == target_value
        node.neighbors.each{ |ele| q << ele if !seen.include?(ele)}
    end
    nil
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

p bfs(a, "b")

p bfs(a, "f")