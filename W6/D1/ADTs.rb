# Exercise 1 - Stack
# Let's write a Stack class. To do this, use the following framework:

  class Stack
    def initialize
      # create ivar to store stack here!
      @s = []
    end

    def push(el)
      # adds an element to the stack
      @s << el
    end

    def pop
      # removes one element from the stack
      @s.pop
    end

    def peek
      # returns, but doesn't remove, the top element in the stack
      @s[-1]
    end
  end
# To test that your code works, create a new instance of the Stack class, and play around with adding and removing elements. Remember, a stack follows the principle of LIFO!


# Exercise 2 - Queue
class Queue
    def initialize
        @q = []
    end

    def enqueue(ele)
        @q << ele
    end
    
    def dequeue
        @q.shift
    end

    def peek
        @q[0]
    end
end

# Now let's write a Queue class. We will need the following instance methods: enqueue(el), dequeue, and peek.

# Test your code to ensure it follows the principle of FIFO.

# Exercise 3 - Map

class Map
    def initialize
        @m = []
    end

    def set(k, v)
        @m.each.with_index do |ele, i|
            if @m[i][0] == k
                @m[i][1] = v
                return
            end
        end
        @m << [k, v]
    end

    def get(key)
        @m.each.with_index do |ele, i|
            if @m[i][0] == ele
                return @m[i][1]
            end
        end
        nil
    end
    
    def delete(key)
        val = get(key)
        @m.reject!{ |pair| pair[0] == key}
        val
    end
end
# As you saw in the videos for tonight, a map can be implemented using a 2D array. Let's write a Map class (following a similar pattern to Stack and Queue) that implements a map using only arrays.

# Remember, a map stores information in key-value pairs, where the keys are always unique. When implemented with arrays, a map might look something like this: my_map = [[k1, v1], [k2, v2], [k3, v2], ...].

# Our Map class should have the following instance methods: set(key, value), get(key), delete(key), show. Note that the set method can be used to either create a new key-value pair or update the value for a pre-existing key. It's up to you to check whether a key currently exists!

# As always, test your code thoroughly to make sure all properties of maps are enforced.