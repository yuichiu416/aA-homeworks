require_relative "board"
require_relative "card"

class Game

    attr_reader :grid
    def initialize()
        @grid = Board.new
    end

    def play
        @grid.render
        move1 = get_move
        while move1 == nil
            move1 = get_move
        end
        @grid.reveal(move1)
        @grid.render

        move2 = get_move
        while move2 == nil
            move2 = get_move
        end
        @grid.reveal(move2)
        @grid.render


        # what to do with two values the player flipped
        card1 = @grid[move1]
        card2 = @grid[move2]
        if card1.value != card2.value
            sleep(5)
            @grid.reveal(move1)
            @grid.reveal(move2)
            system("clear")
            @grid.render
        end
    end

    def get_move
        valid = [0,1,2,3]
        puts "Input your move with the format:`i j`"
        moves = gets.chomp.split(" ").map(&:to_i)
        if moves.length != 2 || !valid.include?(moves[0]) || !valid.include?(moves[1])
            puts "there's something wrong with the input, please try again"
            moves = nil
        end
        moves
    end
    
end
