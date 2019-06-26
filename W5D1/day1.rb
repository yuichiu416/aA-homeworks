
# Enumerable
# My Each
# Extend the Array class to include a method named my_each that takes a block, calls the block on every element of the array, and returns the original array. Do not use Enumerable's each method. I want to be able to write:

#  calls my_each twice on the array, printing all the numbers twice.

p "my_each"
class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end
end
return_value = [1, 2, 3].my_each do |num|
  puts num
end.my_each do |num|
  puts num
end
# => 1
#  2
#  3
#  1
#  2
#  3

# p return_value  # => [1, 2, 3]
p "my_select"
# My Select
# Now extend the Array class to include my_select that takes a block and returns a new array containing only elements that satisfy the block. Use your my_each method!

# Example:

class Array
    def my_select(&prc)
        ans = []
        self.my_each{ |ele| ans << ele if prc.call(ele) }
        ans
    end
end
a = [1, 2, 3]
p a.my_select { |num| num > 1 } # => [2, 3]
p a.my_select { |num| num == 4 } # => []

# My Reject
# Write my_reject to take a block and return a new array excluding elements that satisfy the block.

# Example:

class Array
    def my_reject(&prc)
        ans = []
        self.my_each{ |ele| ans << ele if !prc.call(ele)}
        ans
    end
end

p "my_reject"
a = [1, 2, 3]
p a.my_reject { |num| num > 1 } # => [1]
p a.my_reject { |num| num == 4 } # => [1, 2, 3]

# My Any
# Write my_any? to return true if any elements of the array satisfy the block and my_all? to return true only if all elements satisfy the block.

# Example:

class Array
    def my_any?(&prc)
        self.my_each { |ele| return true if prc.call(ele) }
        false 
    end
end

p "my_any?"
a = [1, 2, 3]
p a.my_any? { |num| num > 1 } # => true
p a.my_any? { |num| num == 4 } # => false

class Array
    def my_all?(&prc)
        self.my_each do |ele|
            return false if !prc.call(ele)
        end
        true
    end
end
p "my_all?"
p a.my_all? { |num| num > 1 } # => false
p a.my_all? { |num| num < 4 } # => true

# Array
# My Flatten
# my_flatten should return all elements of the array into a new, one-dimensional array. Hint: use recursion!

# Example:
class Array
    def my_flatten
        flattened = []
        self.each{ |ele| ele.is_a?(Array) ? flattened += ele.my_flatten : flattened << ele }
        flattened
    end
end
p "my_flatten"
p [1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

# My Zip
# Write my_zip to take any number of arguments. It should return a new array containing self.length elements. Each element of the new array should be an array with a length of the input arguments + 1 and contain the merged elements at that index. If the size of any argument is less than self, nil is returned for that location.

# Example:

class Array
    def my_zip(*arrays)
        # solution: 
        # zipped = []
        # self.length.times do |i|
        #     subzip = [self[i]]

        #     arrays.each do |array|
        #         subzip << array[i]
        #     end
        #     zipped << subzip
        # end
        # zipped

        new_arr = []
        zipped = []
        new_arr << self
        arrays.each do |sub|
            new_arr << sub
        end
        new_arr.each_with_index do |ele1, idx1|
            row = []
            new_arr.each_with_index do |ele2, idx2|
                row << new_arr[idx2][idx1]
            end
            next if zipped.length == self.length
            zipped << row
        end

        zipped.select{ |row| !row.all? (nil)}
    end
end
#   [ 1, 2, 3 ] #[nil, nil, nil]
a = [ 4, 5, 6 ] #[nil, nil, nil]
b = [ 7, 8, 9 ] #[nil, nil, nil]

p "my_zip"
p [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
p a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
p [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]

c = [10, 11, 12]
d = [13, 14, 15]
p [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

# # My Rotate
# # Write a method my_rotate that returns self rotated. By default, the array should rotate by one element. If a negative value is given, the array is rotated in the opposite direction.

# # Example:

class Array
    def my_rotate(num = 1)
        # solution 1
        # split_idx = num % self.length
        # self.drop(split_idx) + self.take(split_idx)
        
        # solution 2
        # x = (num % self.length)
        # self[x..-1] + self[0..x-1]

        copy = self.dup
        num.abs.times do
            if num > 0
                copy << copy.shift
            else
                copy.unshift(copy.pop)
            end
        end
        copy
    end
end

a = [ "a", "b", "c", "d" ]
p "my_rotate"
p a.my_rotate         #=> ["b", "c", "d", "a"]
p a.my_rotate(2)      #=> ["c", "d", "a", "b"]
p a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
p a.my_rotate(15)     #=> ["d", "a", "b", "c"]

# # My Join
# # my_join returns a single string containing all the elements of the array, separated by the given string separator. If no separator is given, an empty string is used.

# # Example:

class Array
    def my_join(seperator = "")
        new_str = self[0]
        (1...self.length).each{ |i| new_str += seperator + self[i]}
        new_str 
    end
end
a = [ "a", "b", "c", "d" ]
p "my_join"
p a.my_join         # => "abcd"
p a.my_join("$")    # => "a$b$c$d"

# # My Reverse
# # Write a method that returns a new array containing all the elements of the original array in reverse order.

# # Example:

class Array
    def my_reverse
        new_arr = []
        (self.length - 1).downto(0){ |i| new_arr << self[i]}
        new_arr
    end
end
p "my_reverse"
p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1]

# Review
# Now that we're all warmed up, let's review the iteration exercises from the prepwork. Implement the following methods:

# #factors(num)
# #bubble_sort!(&prc)
# #bubble_sort(&prc)
# #substrings(string)
# #subwords(word, dictionary)

def factors(num)
    new_arr = []
    (1..num).each { |ele| new_arr << ele if num % ele == 0 }
    new_arr
end

class Array
    def bubble_sort!(&prc)
        prc ||= Proc.new { |a, b| a <=> b }
        sorted = false
        while !sorted
            sorted = true
            (0...self.length - 1).each do |i|
                if prc.call(self[i], self[i + 1]) == 1
                    self[i], self[i + 1] = self[i + 1], self[i]
                    sorted = false
                end
            end
        end
        self          
    end
end

def substrings(string)
    ans = []
    (0...string.length).each do |idx1|
        (idx1...string.length).each do |idx2|
            ans << string[idx1..idx2]
        end
    end
    ans
end

def subwords(word, dictionary)
    new_arr = []
    dictionary.each do |sub|
        if word.include?(sub)
            new_arr << sub
        end
    end
    new_arr
end

p "factors"
p factors(12) # 1, 2, 3, 4, 6, 12
p "bubble_sort!"
p [6,1,7,8,2,4,3,5].bubble_sort!() # [1,2,3,4,5,6,7,8]
p "substrings"
p substrings("abc") # a, b, c, ab, ac, abc
p "subwords"
p subwords("asdfcatqwer", ["cat", "car"]) # => ["cat"]


# # Although these exercises are from the prepwork and come with specs, use this opportunity to practice your own testing skills. Write out each method, think of a few different example cases, and test out your code in pry.

# # If you are having a tough time thinking of example cases, check out the specs. You can use those examples to test your solutions. Don't forget to move your enumerables_array.rb into a lib directory!