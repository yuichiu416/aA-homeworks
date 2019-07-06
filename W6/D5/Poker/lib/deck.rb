require_relative "card"
class Deck

    attr_accessor :deck
    def initialize
        @deck = []
        initialize_helper
    end

    def initialize_helper
        Card::SUITS.each do |suit|
            Card::NUMBERS.each do |number|
                @deck << Card.new(suit, number)
            end
        end
        @deck.shuffle!
    end

end
