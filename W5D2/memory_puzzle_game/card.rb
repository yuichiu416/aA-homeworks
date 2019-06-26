class Card
    attr_reader :VALUES, :value
    attr_accessor :face_down

    VALUES = ("A".."Z").to_a

    def initialize(index)
        @value = VALUES[index]
        @face_down = false
    end

    def hide
        @face_down = true
    end

    def reveal
        @face_down = false
    end

    def to_s
    end

    def ==
    end
end