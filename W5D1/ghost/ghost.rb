require "set"
class Ghost

    attr_reader :currentPlayer, :scores, :players
    attr_accessor :fragment

    def initialize(player_number)
        @players = Array.new(player_number)
        @scores = Array.new(player_number, 0)
        (1..player_number).each{ |i| @players[i - 1] = "Player#{i}"}
        @fragment = ""
        @dictionary
        @currentPlayer = @players.index(@players.sample)
    end

    def reset
        @fragment = ""
        @currentPlayer = @players.index(@players.sample)
        p self
    end

    def getUserInput
        p "Input a letter"
        input = gets.chomp.downcase
        input = input[0]

        while !valid?(@fragment + input)
            p "Invalid input! Input a letter again:"
            input = gets.chomp
            input = input[0]
        end
        @fragment += input
    end

    def valid?(fragment)
        p "fragment is #{fragment}"
        new_dic = @dictionary.select{ |word| word.start_with?(fragment)}
        @dictionary = new_dic if new_dic.length >= 1
        new_dic.length >= 1
    end

    def lose?
        if @dictionary.length == 1
            calculateLoser 
            return true
        end
        false
    end

    def calculateLoser
        #when the dictionary is only one word left, we can know whos going to lose in which round
        diff = @dictionary[0].length - fragment.length 
        loser = diff % @players.length
        @players[loser]
    end

    def switchPlayer
        @currentPlayer += 1
        @currentPlayer %= @players.length
    end

    def reload
        File.open("./dictionary.txt", "r") do |f|
            @dictionary = Set.new
            f.each_line do |line|
                @dictionary.add(line)
            end
        end
    end

    def calculate_scores
        # get everyone one point but the loser
        # @currentPlayer stores the index of the current player
        diff = @dictionary[0].length - fragment.length

        @scores.each_with_index { |score, index| @scores[index] += 1 if index != (@currentPlayer + diff - 1) % @players.length}
        p @scores
    end

    def see_current_player_score
        p @scores
    end

    def game_over?
        @scores.any? { |ele| return true if ele == 5 }
    end

end

p "How many players are there?"
player_number = gets.chomp.to_i

ghost = Ghost.new(player_number)
round = 0
while !ghost.game_over?
    ghost.reload
    while !ghost.lose?
        ghost.getUserInput
        ghost.switchPlayer
    end
    ghost.reset
    round += 1
    ghost.calculate_scores
    p "round #{round} over"
end
winners = []
ghost.scores.each_with_index{ |score, i| winners << ghost.players[i] if score == 5}

p winners