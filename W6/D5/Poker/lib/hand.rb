require_relative "deck"

class Hand
    attr_reader :cards
    
    def initialize(cards)
        @cards = cards
    end

    def compare_cards(cards1, cards2)
        rule1 = meet_rule(cards1)
        rule2 = meet_rule(cards2)
        if rule1 < rule2
            p "cards1 wins"
        elsif rule == rule2
            p compare_suits_when_all_cards_are_same(cards1, cards2)
        else
            p "cards 2 wins"
        end
    end


    def meet_rule(cards)
        if is_Royal_flush?(cards)
            return 1
        elsif is_Straight_flush?(cards)
            return 2
        elsif is_four_of_a_kind?(cards)
            return 3
        elsif is_full_house?(cards)
            return 4
        end
    end

    def is_a_pair?(cards)
    end

    def is_two_pairs?(cards)
    end

    def is_full_house?(cards)
     K K A A A , A A K K K
    end

    def is_four_of_a_kind?(cards)
        duplicates = Hash.new(0)
        cards.each { |card| duplicates[card.number] += 1 }
        p duplicates
        return true if duplicates.values.any?{ |val| val == 4}
        false
    end

    def compare_suits_when_all_cards_are_same(cards1, cards2)
        Card::SUITS.index(cards1[0].suit) <=> Card::SUITS.index(cards2[0].suit)
    end

    def is_Royal_flush?(cards)
        return false if !all_cards_is_the_same_suit?(cards)
        royal = %w(A K Q J 10)
        numbers = []
        cards.each{ |card| numbers << card.number}
        royal.sort == numbers.sort
    end

    def all_cards_is_the_same_suit?(cards)
        suit = cards[0].suit
        return false if cards.any?{ |card| card.suit != suit}
        true
    end
    
    def is_Straight_flush?(cards)
        return false if !all_cards_is_the_same_suit?(cards)
        numbers = %w(2 3 4 5 6 7 8 9 10 J Q K A)
        card_nums = []
        cards.each{ |card| card_nums << card.number}
        card_nums.sort!
        for i in 0..7 
            return true if numbers[i...i+5].sort == card_nums
        end
        false
    end

    def numbers
        ans = []
        @cards.each{ |card| ans << card.number}
        ans
    end
end

cards1 = []
cards1 << Card.new("spade", "2")
cards1 << Card.new("spade", "2")
cards1 << Card.new("spade", "3")
cards1 << Card.new("spade", "4")
cards1 << Card.new("spade", "3") 

cards2 = []
cards2 << Card.new("heart", "A")
cards2 << Card.new("heart", "K")
cards2 << Card.new("heart", "Q")
cards2 << Card.new("heart", "J")
cards2 << Card.new("heart", "10") 

h1 = Hand.new(cards1)
h2 = Hand.new(cards2)

p h1.is_Straight_flush?(cards1)
p h1.is_four_of_a_kind?(cards1)

# p h1.meet_rule?(h2.cards)



=begin
spade = "U+2664"
club = U+2667
dimond = U+2662
heart = U+2661

=end

=begin     
1. Royal flush 
A, K, Q, J, 10, all the same suit. 
A K Q J T

2. Straight flush 
Five cards in a sequence, all in the same suit. 
8 7 6 5 4 

3. Four of a kind 
All four cards of the same rank. 
J J J J 

4. Full house 
Three of a kind with a pair. 
T T T 9 9

5. Flush 
Any five cards of the same suit, but not in a sequence. 
4 J 8 2 9

6. Straight 
Five cards in a sequence, but not of the same suit. 
9 8 7 6 5

7. Three of a kind 
Three cards of the same rank. 
7 7 7 K 3

8. Two pair 
Two different pairs. 
4 4 3 3 Q

9. Pair 
Two cards of the same rank. 
A A 8 4 7

10. High Card 
When you haven't made any of the hands above, the highest card plays. 
In the example below, the jack plays as the highest card. 
3 J 8 4 2

=end 