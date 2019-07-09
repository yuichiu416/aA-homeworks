$arr = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# "fiiiissshhhhhh"
def sluggish
    max = ""
    for i in 0...$arr.length
        temp = $arr[i]
        max = temp if $arr.all?{ |fish| temp.length >= fish.length}
    end
    max
end

def clever
    max = ""
    for i in 0...$arr.length
        max = $arr[i] if $arr[i].length > max.length
    end
    max
end

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up"]

def slow(direction, tiles_array)
    for i in 0...tiles_array.length
        return i if direction == tiles_array[i]
    end
end

tiles_hash = {"up" => 0, "right-up" => 1, "right" => 2, "right-down" => 3, "down" => 4, "left-down" => 5, "left" => 6,  "left-up" => 7}

def constant(direction, tiles_hash)
    tiles_hash[direction]
end
