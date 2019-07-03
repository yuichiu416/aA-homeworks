require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :children
  attr_accessor :prev_move_pos, :next_mover_mark
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @children = []
  end

  def losing_node?(evaluator)
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    (0..2).each do |row|
      (0..2).each do |col|
        child = TicTacToeNode.new(@board.dup , @next_mover_mark, prev_move_pos)
        if child.board.rows[row][col] == nil
          
          if @next_mover_mark == :o
            child.next_mover_mark = :x
          else
            child.next_mover_mark = :o
          end
         
          child.prev_move_pos = [row, col]
          @children << child
          next
        end
      end




    end
    @children
  end
end

# For each empty position, create a node by duping the board and putting a next_mover_mark in the position. You'll want to alternate next_mover_mark so that next time the other player gets to move. Also, set prev_move_pos to the position you just marked, for reasons that will make sense when we use it later.



# 0 0 0
# 0 0 0
# 0 0 0

# X O 0
# 0 0 0
# 0 0 0

# X 0 O
# 0 0 0
# 0 0 0