
def exp_one(b, n)
    return 1 if n == 0
    return b if n == 1
    b * exp_one(b, n - 1)
end

def exp_two(b, n)
    return 1 if n == 0
    return b if n == 1
    if n.even? 
        exp_two(b, n / 2) * exp_two(b, n / 2)
    else
        b * exp_two(b, (n-1) / 2) * b
    end
end
    

p "exp_one"
p exp_one(1, 0) #1
p exp_one(1, 1) #1
p exp_one(1, 2) #1
p exp_one(2, 0) #1
p exp_one(2, 1) #2
p exp_one(2, 2) #4

p "exp_two"
p exp_two(1, 0) #1
p exp_two(1, 1) #1
p exp_two(1, 2) #1
p exp_two(2, 0) #1
p exp_two(2, 1) #2
p exp_two(2, 2) #4

class Array
    def deep_dup
        self.map {|x| x.is_a?(Array) ? x.deep_dup : x}
    end
end
# Deep dup
# The #dup method doesn't make a deep copy:

robot_parts = [
  ["nuts", "bolts", "washers"],
  ["capacitors", "resistors", "inductors"]
]

robot_parts_copy = robot_parts.deep_dup

# # shouldn't modify robot_parts
robot_parts_copy[1] << "LEDs"
# # but it does
p "copy"
p robot_parts_copy[1]
p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
# When we dup an Array, it creates a new array to hold the elements, but doesn't recursively dup any arrays contained therein. So the dup method creates one new array, but just copies over references to the original interior arrays.

arr = [1, [2], [3, [4]]]
arr_copy = arr.deep_dup

arr_copy[2] << 555
p "copy"
p arr_copy
p arr 

# Sometimes you want a shallow dup and sometimes you want a deep dup. Ruby keeps things simple by giving you shallow dup, and letting you write deep dup yourself.

# Using recursion and the is_a? method, write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

# Note: For simplicity's sake, we are only going to ensure the deep duplication of arrays. Don't worry about deep-duping (or regular-duping) other types of mutable objects (like strings, hashes, instances of custom classes, etc.), since this would require that we implement a deep dup method for each of those classes, as well.

# It's okay to iterate over array elements using the normal each for this one :-)

# You should be able to handle "mixed" arrays. For instance: [1, [2], [3, [4]]].

# Fibonacci
# Write a recursive and an iterative Fibonacci method. The method should take in an integer n and return the first n Fibonacci numbers in an array.

def fib_r(n)
    fibb_arr = [0,1].take(n)
    return fibb_arr if n <= 2
    fibb = fib_r(n - 1)
    fibb << fibb[-2] + fibb[-1]
end

def fib_i(n)
    arr = [0,1]
    while arr.length < n
        arr << arr[-1] + arr[-2]
    end
    arr

end

p "fib"
p fib_r(5) #3
p fib_i(5) #3

p fib_r(7) #8
p fib_i(7) #8


# You shouldn't have to pass any arrays between methods; you should be able to do this just passing a single argument for the number of Fibonacci numbers requested.

# Binary Search
# The binary search algorithm begins by comparing the target value to the value of the middle element of the sorted array. If the target value is equal to the middle element's value, then the position is returned and the search is finished. If the target value is less than the middle element's value, then the search continues on the lower half of the array; or if the target value is greater than the middle element's value, then the search continues on the upper half of the array. This process continues, eliminating half of the elements, and comparing the target value to the value of the middle element of the remaining elements - until the target value is either found (and its associated element position is returned), or until the entire array has been searched (and "not found" is returned).

# Write a recursive binary search: bsearch(array, target). Note that binary search only works on sorted arrays. Make sure to return the location of the found object (or nil if not found!). Hint: you will probably want to use subarrays.

# Make sure that these test cases are working:

def bsearch(arr, key)
    # raise "The array is not sorted" if arr != arr.sort
    # first_idx = 0
    # mid = arr.length / 2
    # last = arr.length - 1
    # return nil if arr.empty?
    # if arr[mid] > key
    #     left = arr[0..(mid - 1)]
    #     return nil if key < arr[0]
    #     bsearchl = bsearch(left, key)

    # elsif arr[mid] < key
    #     right = arr[(mid + 1)..last]
    #     bsearchr = bsearch(right, key)
    #     bsearchr.nil? ? nil : bsearchr + mid + 1
    # else
    #     return mid
    # end

    raise "The array is not sorted" if arr != arr.sort
    mid = (0 + arr.length - 1)/2

    if arr[mid] == key
        return mid
    elsif arr[mid] > key
        return nil if key < arr[0]
        bsearchl = bsearch(arr[0..mid - 1], key)
    elsif arr[mid] < key
        bsearchr = bsearch(arr[(mid+1)..-1], key)
        bsearchr.nil? ? nil : bsearchr + mid + 1
    end

end


p "bsearch"
p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
# Merge Sort
# Implement a method merge_sort that sorts an Array:

def merge_sort(arr)
    return arr if arr.length <= 1
    middle = arr.length / 2
    left = arr[0...middle]
    right = arr[middle...arr.length]
    merge(merge_sort(left), merge_sort(right))
end

def merge(left, right)
    sorted = []
    until left.empty? || right.empty?
        sorted << (left.first <= right.first ? left.shift : right.shift)
    end
    sorted + left + right
end


# The base cases are for arrays of length zero or one. Do not use a length-two array as a base case. This is unnecessary.
# You'll want to write a merge helper method to merge the sorted halves.
# To get a visual idea of how merge sort works, watch this gif and check out this diagram.

p "merge"
arr = (0..10).to_a.shuffle
p merge_sort(arr)


def subsets(arr)
    return [[]] if arr.empty?
    subs1 = subsets(arr[0..-2])
    subs2 = []
    subs1.each do |subs|
        subs2 << subs + [arr.last]
    end
    subs1 + subs2
end

# Array Subsets
# Write a method subsets that will return all subsets of an array.

# subsets([]) # => [[]]
# subsets([1]) # => [[], [1]]
# subsets([1, 2]) # => [[], [1], [2], [1, 2]]
p "subsets"
p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

# You can implement this as an Array method if you prefer.

# Hint: For subsets([1, 2, 3]), there are two kinds of subsets:

# Those that do not contain 3 (all of these are subsets of [1, 2]).
# For every subset that does not contain 3, there is also a corresponding subset that is the same, except it also does contain 3.
# Permutations
# Write a recursive method permutations(array) that calculates all the permutations of the given array. For an array of length n there are n! different permutations. So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations.
class Array
    def permutations
        return [self] if length <= 1
        perms = []
        each {|n| (self - [n]).permutations.each {|p| perms << ([n] + p)}}
        perms
    end
end
p "permutations"
p [1,2,3].permutations # => [[1, 2, 3], [1, 3, 2],
                        #     [2, 1, 3], [2, 3, 1],
                        #     [3, 1, 2], [3, 2, 1]]
# You can use Ruby's built in Array#permutation method to get a better understanding of what you will be building.

# [1, 2, 3].permutation.to_a  # => [[1, 2, 3], [1, 3, 2],
#                             #     [2, 1, 3], [2, 3, 1],
#                             #     [3, 1, 2], [3, 2, 1]]
