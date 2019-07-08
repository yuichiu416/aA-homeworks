# 1. **What is a class?**

# A group of variable and methods that are all related to a particular object


# **Answer:** A text-book answer: classes are a blue-print for constructing computer models for real or virtual objects.

# In reality: classes hold data, have methods that interact with that data, and are used to instantiate objects.

# 1. **What is an object?**

# **Answer:**
# An instance of a class. It's also the root class in ruby (Object). Classes themselves descend from the Object root class.



# 2. **What does self mean?**
# **Answer:**
# `self` always refers to the current object. But this question is more difficult than it seems because Classes are also objects in ruby.

```rb

class WhatIsSelf
  def test
    puts "At the instance level, self is #{self}"
  end

  def self.test
    puts "At the class level, self is #{self}"
  end
end


WhatIsSelf.test
 #=> At the class level, self is WhatIsSelf

WhatIsSelf.new.test
 #=> At the instance level, self is #<WhatIsSelf:0x28190>

```

2. **Explain this ruby idiom: `a ||= b`**

def func(&prc)
    prc ||= Proc.new{ |x| x += 1}

end
**Answer:**
If the `a` is false then `a = b`. If the `a` side is true then `a` isn't reassigned.



3. **What is the use of `super`?**
It calls a method on the parent class with the same name as the method that calls `super`.


3. **What is unit testing? What is the primary technique when writing a test?**
   
   a. test with edge cases
   b. don't let the return value of other methods play a role in our test
   c. use double to create some "fake" inputs/expected outputs

   Unit testing, simply put, is testing methods -- the smallest unit in object-oriented programming. The primary way to achieve this is to assert that the **actual** result of the method matches an **expected** result.

   RSpec.describe Calculator do
      it "add method add numbers do
        calc = Calculator.new
        expect(calc.add(5, 10)).to eq(15)
      end
   end

### OOP – Jukebox
### Prompt
Design a musical jukebox using object-oriented principles.

class Jukebox
  def initialize(songs, volume)
    @songs = songs
    @volume = volume
  end

  def play_song(specified_song)

  end  
end

class Player

  def initialize(name, favorites )
end

class Playlist
  def initialize
    @songs = []
  end
end


```ruby
class Jukebox
  attr_accessor :user
  attr_reader :current_track

  def initialize(player, user)
    @player = player
    @user = user
    @current_track = nil
  end
end

class Player
  attr_accessor :album, :playlist

  def initialize(album, playlist)
    @album = album
    @playlist = playlist
  end

  def play_track(track)
    # Begin playing...
  end
end

class Playlist
  def initialize
    @queue = []
  end

  def add_track(track)
    @queue.push(track)
  end

  def shift
    @queue.shift
  end
end

class Album
  # Information about the album
end

class Track
  # Information about the track, including album
end

class User
  # Information about the user.
end
```

### OOP – Parking Lot

### Prompt

Design a parking lot using object-oriented principles.

class ParkingLot
  
end

class Car
  def initialize(start, end, plate_number)
    @start = start
    @end = end
    @plate_number = plate_number
  end
end

```ruby
class Vehicle
  attr_reader :spots_needed, :size

  def initialize(license_plate)
    @parking_spots = []
    @license_plate = license_plate
  end

  def park_in_spot(spot)
    # ...
  end

  def clear_spots
    # ...
  end

  def can_fit_in_spot(spot)
    # ...
  end
end

class Bus < Vehicle
  def initialize
    super
    @spots_needed = 5
    @size = :large
  end

  def can_fit_in_spot(spot)
    # Checks if spot is :large
  end
end

class Car < Vehicle
  def initialize
    super
    @spots_needed = 1
    @size = :compact
  end

  def can_fit_in_spot(spot)
    # Check if spot is :compact or :large
  end
end

class Motorcycle < Vehicle
  def initialize
    super
    @spots_needed = 1
    @size = :compact
  end
end

class ParkingLot
  def initialize
    @levels = # generate_levels
  end

  def park_vehicle(vehicle)
    # Park the vehicle in a spot or multiple spots. Return false if failed.
  end
end

class Level
  def initialize(floor, num_spots)
    @spots = # generate spots
    @available_spots = num_spots
    @floor = floor
  end

  def park_vehicle(vehicle)
    # Find a place to park vehicle or return false.
  end

  def park_starting_at(spot_num, vehicle)
    # Park a vehicle starting at spot number and continue until vehicle.spots_needed.
  end

  def find_available_spots(vehicle)
    # Find a spot to park the vehicle. Return index of spot or -1.
  end

  def spot_freed
    @available_spots += 1
  end
end

class ParkingSpot
  attr_reader :row, :spot_num

  def initialize(size, level, row, spot_num)
    @vehicle = nil
    @spot_size = size
    @level = level
    @row = row
    @spot_num = spot_num
  end

  def is_free?
    !@vehicle
  end

  def can_fit_vehicle?(vehicle)
    # Check it will fit.
  end

  def park(vehicle)
    # Park in spot
  end

  def unpark
    # Remove vehicle from spot and notify level that a new spot is available.
  end
end

## Implement BFS

# For this problem assume there is a Node class. The node class will take in a value as part of its initialization. You will be monkeypatching the following method:

# Write a method `bfs` that does a breadth-first search starting at a root node. It takes in a target, and a proc as an argument.

# Example usage:

```ruby
n1 = Node.new(1) making a node with a value of 1

n1.bfs(1) #=> n1

```


class Node

  # -- Assume nodes have a value, and a attr_reader on value
  # -- Also, assume there are working parent/child-related methods for Node
  def children
    ..
  end

  def bfs(&prc)
    queue = [self]

    until queue.empty?
      visited = queue.shift
      if prc.call(visited)  
        return visited
      else
        queue += visited.children
      end 
    end
    nil
  end
end
```



class Node

  # -- Assume nodes have a value, and a attr_reader on value
  # -- Also, assume there are working parent/child-related methods for Node

  def bfs(&prc)
    raise "Must give a proc or target" if prc.nil?

    queue = [self]

    until queue.empty?
      visited = queue.shift
      return visited if prc.call(visited)
      queue += visited.children
    end

    nil
  end
end
```
<!-- ## Implement DFS

For this problem assume there is a Node class. The node class will take in a value as part of its initialization. You will be monkeypatching the following method:

Write a method `dfs` that does a depth-first search starting at a root node. It takes in a target, and a proc as an argument.

Example usage:

```ruby
n1 = Node.new(1) #making a node with a value of 1

n1.dfs { |node| node.value == 1 } #=> n1 (found a node with value == 1) -->
```

dfs(&prc)
  return nil if children.empty? && !prc.call(self)
  return self if prc.call(self)

  children.each do |child|
    result = child.dfs(&prc)
    return result if result != nil
  end
  nil
end

class Node

  # -- Assume nodes have a value, and a attr_reader on value
  # -- Also, assume there are working parent/child-related methods for Node
  def dfs(, &prc)
    raise "Must give a proc or target" if prc.nil?

    return self if prc.call(self)

    self.children.each do |node|
      result = node.dfs(target, &prc)
      return result if result
    end

    nil
  end
end