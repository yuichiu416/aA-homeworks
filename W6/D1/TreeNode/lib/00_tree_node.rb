class PolyTreeNode
    
    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent
        @parent
    end
   
    def children
        @children
    end
    
    def value
        @value  
    end

    def parent=(mom) #pass nil to the methods, to make you an orphan
        @parent.children.delete(self) if @parent != nil
        @parent = mom
        mom.children << self if mom != nil
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(node)
        raise "The node is nil" if node.nil?
        if node.parent == self
            node.parent = nil
            self.children.delete(node)
        else
            raise "This node is not a child"
        end
    end

    def dfs(target)
        return nil if @children.empty? && self.value != target
        return self if self.value == target
        @children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end
        nil
    end

    def bfs(target)
        queue = [self]
        while !queue.empty?
            el = queue.shift
            return el if el.value == target
            el.children.each {|child| queue << child}
        end
        nil
    end

    def inspect
        @value.inspect
    end
end


#A #parent method that returns the node's parent.