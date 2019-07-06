class Card
    SUITS = %w(spade club dimond heart)
    NUMBERS = %w(2 3 4 5 6 7 8 9 10 J Q K A)

    attr_reader :suit, :number
    def initialize(suit, number)
        @suit = suit
        @number = number
    end

    def inspect
        "#{@suit} #{@number}\n"
    end
end