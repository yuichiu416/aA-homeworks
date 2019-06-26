require 'set'
class WorldChainer
    attr_accessor :dictionary
    def initialize(dictionary)
        @dictionary = Set.new(File.readlines("dictionary.txt").map(&:chomp))
    end
    
    def adjacent_words(word)
        adjacent = []
        alpha = ("a".."z").to_a
        word.each_char.with_index do |old, idx|
            alpha.each do |new_let|
                next if old == new_let
                new_word = word.dup
                new_word[idx] = new_let
                adjacent << new_word if dictionary.include?(new_word)
            end
        end
        adjacent
    end
    
    def run(source, target)
        @current_words = [source]
        @all_seen_words = []
        @new_current_words = []
        @current_words.each do |current|
            @new_current_words += adjacent_words(current)
            @all_seen_words += @new_current_words
            
        end
        @all_seen_words
    end

end
if $PROGRAM_NAME == __FILE__
    wc = WorldChainer.new(ARGV.shift).run("bike", "wise")
    p wc
end