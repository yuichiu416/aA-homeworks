require_relative "../TreeNode/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_reader :root_node, :considered_positions
    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
    end

    def self.valid_moves(pos)
        one = [-2, -1, 1, 2]
        two = [-2, -1, 1, 2]
        row, col = pos
        possible = []
        one.each do |i|
            two.each do |j|
                next if row + i > 7 || row + i < 0 || col + j > 7 || col + j < 0 || (i + j).even?
                possible << [row + i, col + j]
            end
        end
        possible    
    end

    def build_move_tree
        queue = [@root_node]
        while !queue.empty?
            new_moves = new_move_positions(queue[0]) 
            new_moves.each  do |pos| 
                child = PolyTreeNode.new(pos)
                queue << child
                queue[0].add_child(child)
            end
            queue.shift
        end
    end

    def find_path(target)
        result = @root_node.dfs(target)
        path = []
        while result
            path << result.value
            result = result.parent
        end
        path.reverse
    end

    def trace_back_path(target)
        path = []
        while target.parent.value != @root_node.value
            path.unshift(target.value)
            target = target.parent
        end
        path.unshift(target.value)
        path.unshift(@root_node.value)
        path
    end
    
    def new_move_positions(parent_node)
        new_moves = KnightPathFinder::valid_moves(parent_node.value)
        new_moves.reject! {|child| @considered_positions.include?(child)}
        new_moves.each { |pos| @considered_positions << pos}
        new_moves
    end
    
end
if __FILE__ == $PROGRAM_NAME
    k = KnightPathFinder.new([0,0])
    k.build_move_tree
end
