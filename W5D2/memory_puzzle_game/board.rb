require_relative "card"
class Board

    def initialize
        @grid = Array.new(4){Array.new(4, nil)}
        @pairs = []
        @deck = []
        populate
    end
    
    def populate
        while @pairs.length < 8
            @pairs << (0..25).to_a.sample
            @pairs.uniq!
        end
        @pairs.each do |index|
            @deck << Card.new(index)
            @deck << Card.new(index)
        end
        for i in 0..3
            for j in 0..3
                # TODO: explore why delete doesn't work here
                # card = @deck.sample
                # @grid[i][j] = card
                # debugger
                # @deck.delete(card)
                
                index = rand(0...@deck.length)
                card = @deck[index]
                @grid[i][j] = card
                @deck.delete_at(index)
            end
        end
    end

    def render
        #should print out a representation of the Board's current state
        grid = "  0 1 2 3\n"
        for i in 0..3
            grid += i.to_s + " "
            for j in 0..3
                card = @grid[i][j]
                # if it's face down
                card.face_down ? grid += "# " : grid += card.value + " "
            end
            grid += "\n"
        end
        puts grid
    end

    def won?
        # should return true if all cards have been revealed.
        if @grid.all? { |row| row.all? {|card| !card.face_down}}
            puts "YOU WON" 
            return true
        else
            return false
        end
    end

    def reveal(move)
        i, j = move
        card = @grid[i][j]
        if card.face_down
            card.reveal
        else
            card.hide
        end
    end

    def [](move)
        i, j = move
        @grid[i][j]
    end

    def flipAll
        for i in 0..3
            for j in 0..3
                reveal([i, j])
            end
        end
        system("reset")
    end
        
end