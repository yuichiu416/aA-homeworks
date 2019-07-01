require_relative "../TreeNode/lib/00_tree_node.rb"

class KnightPathFinder
    attr_reader :root_node, :considered_positions
    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = []
        @grid = Array.new(8) {Array.new(8)}
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
        @considered_positions = KnightPathFinder::valid_moves(@root_node.value)
        queue = @considered_positions
        while !queue.empty?
            new_moves = new_move_positions(queue[0]) 
            queue += new_moves
            @considered_positions += new_moves
            queue.shift
        end

        p "All possible positions a night can go are: #{@considered_positions}"
    end

    def find_path
        # find_path is called. Don't write this yet though.
    end
    
    def new_move_positions(pos)  
        new_moves = KnightPathFinder::valid_moves(pos)
        new_moves.select {|move| !@considered_positions.include?(move)}
    end
    
end

k = KnightPathFinder.new([0, 0])
k.build_move_tree
