# my_min
# Given a list of integers find the smallest number in the list.

# Example:

#     list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#     my_min(list)  # =>  -5
# Phase I
# First, write a function that compares each element to every other element of the list. Return the element if all other elements in the array are larger.
# What is the time complexity for this function?

def my_min(list)
    # O(n^2)
    counter = 0
    min = 99999999999999999999
    list.each do |ele1|
        temp_min = ele1
        list.each do |ele2|
            counter += 1
            temp_min = ele2 if ele1 > ele2
        end
        min = temp_min if min > temp_min
    end
    p "#{counter == 64}"
    min
end

list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
# p my_min(list)  # =>  -5

# Phase II
# Now rewrite the function to iterate through the list just once while keeping track of the minimum. What is the time complexity?
list = [5, 3, -7]

def my_min(list)
    # O(n)
    counter = 0
    min = list.first
    list.each do |ele|
        counter += 1
        min = ele if min > ele
    end
    p "#{counter == 3}"
    min
end

# p my_min(list)


# Largest Contiguous Sub-sum
# You have an array of integers and you want to find the largest contiguous (together in sequence) sub-sum. Find the sums of all contiguous sub-arrays and return the max.

# Example:

#     list = [5, 3, -7]
#     largest_contiguous_subsum(list) # => 8

#     # possible sub-sums
#     [5]           # => 5
#     [5, 3]        # => 8 --> we want this one
#     [5, 3, -7]    # => 1
#     [3]           # => 3
#     [3, -7]       # => -4
#     [-7]          # => -7
# Example 2:

#     list = [2, 3, -6, 7, -6, 7]
#     largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])
# Example 3:

#     list = [-5, -1, -3]
#     largest_contiguous_subsum(list) # => -1 (from [-1])




# Phase I
# Write a function that iterates through the array and finds all sub-arrays using nested loops. First make an array to hold all sub-arrays. Then find the sums of each sub-array and return the max.
list = [2, 3, -6, 7, -6, 7]
def sub_sum(list)
    subs = []
    list.size.times do |i|
        list.size.times do |j|
            subs << list[i..j]
        end
    end
    subs = subs.reject{ |sub| sub.empty?}.uniq
    sum = list.first
    subs.each do |sub|
        sum = sub.sum if sub.sum > sum
    end
    sum
end
# p sub_sum(list)
# Discuss the time complexity of this solution.

# Phase II
# Let's make a better version. Write a new function using O(n) time with O(1) memory. Keep a running tally of the largest sum.

# Get your story straight, and then explain your solution's time complexity to your TA.
list = [2, 3, -6, 7, -6, 7]

# list = [5, 3, -7]
# => 8

# list = [-5, -1, -3]
# -1
def sub_sum(list)
    best, cur = list[0], 0
    list.each do |n|
         p "best: #{best} n: #{n} cur#{[n, cur + n].max}"     
        cur = [n, cur + n].max
        best = [best, cur].max
    end
    best
end

list = [2, 3, -6, 7, -6, 7]
list = [7 ,-1,-1,-1,7,-1,-1,-1,7]

list = [3,2,-10,16]
# p sub_sum(list)
# p "=========="

def largest_contiguous_subsum2(arr)
  largest = arr.first
  current = arr.first

  return arr.max if arr.all? { |num| num < 0 }

  arr.drop(1).each do |num|
    current = 0 if current < 0
    current += num
    largest = current if current > largest
  end

  largest
end

# p largest_contiguous_subsum2(list)
# p sub_sum(list)

# Anagrams
# Our goal today is to write a method that determines if two given words are anagrams. This means that the letters in one word can be rearranged to form the other word. For example:

def anagram?(str1, str2)
    str1.split("").permutation.to_a.include?(str2.split(""))
end

def first_anagram?(str)
    str.split("").permutation.to_a.join(" ")
end 
# p first_anagram?("elvis")
# p anagram?("gizmo", "sally")    #=> false
# p anagram?("elvis", "lives")    #=> true
# Assume that there is no whitespace or punctuation in the given strings.

# Learning Goals
# Be able to determine the time and space complexity of a method
# Be able to recognize when and how time or space complexity can be improved
# Be able to compare different methods and discuss how changing inputs affects each one's overall runtime
# Phase I:
# Write a method #first_anagram? that will generate and store all the possible anagrams of the first string. Check if the second string is one of these.

# Hints:

# For testing your method, start with small input strings, otherwise you might wait a while
# If you're having trouble generating the possible anagrams, look into this method.
# What is the time complexity of this solution? What happens if you increase the size of the strings?

# Phase II:
# Write a method #second_anagram? that iterates over the first string. For each letter in the first string, find the index of that letter in the second string (hint: use Array#find_index) and delete at that index. The two strings are anagrams if an index is found for every letter and the second string is empty at the end of the iteration.


def anagram?(s1, s2)
    s2 = s2.split("")
    s1.each_char do |char|
        index = s2.index(char)
        s2.delete_at(index) if index
    end
    p s2
    s2.empty?
end
# p anagram?("gizmo", "sally")    #=> false
# p anagram?("elvis", "lives")    #=> true

# Try varying the length of the input strings. What are the differences between #first_anagram? and #second_anagram??

# Phase III:
# Write a method #third_anagram? that solves the problem by sorting both strings alphabetically. The strings are then anagrams if and only if the sorted versions are the identical.

def anagram?(s1, s2)
    s1.split("").sort==s2.split("").sort
end


# p anagram?("gizmo", "sally")    #=> false
# p anagram?("elvis", "lives")    #=> true

# What is the time complexity of this solution? Is it better or worse than #second_anagram??

# Phase IV:
# Write one more method #fourth_anagram?. This time, use two Hashes to store the number of times each letter appears in both words. Compare the resulting hashes.

def anagram(s1, s2)
    count_h = Hash.new(0)
    count_h_2 = Hash.new(0)
    s1.each_char { |char| count_h[char] += 1 }
    s2.each_char { |char| count_h_2[char] += 1 }
    count_h == count_h_2
end

# time : O(n)
# sapce: O(1)
# p anagram?("gizmo", "sally")    #=> false
# p anagram?("elvis", "lives")    #=> true

# What is the time complexity?

# Bonus: Do it with only one hash.


def anagram(s1, s2)
    count_h = Hash.new(0)
    s1.each_char { |char| count_h[char] += 1}
    s2.each_char { |char| count_h[char] -= 1}
    count_h.values.sum == 0 
end
# time : O(n)
# sapce: O(1)
# p anagram?("gizmo", "sally")    #=> false
# p anagram?("elvis", "lives")    #=> true

# Discuss the time complexity of your solutions together, then call over your TA to look at them.

def two_sum?(arr, target)
    hash = {}
    for i in 0...arr.length
        if hash[arr[i]]
            return true
        else
            hash[target - arr[i]] = i
        end
    end
    false
end

arr = [0,2,4,6,8,10,12,14,1]
# two_sum?(arr, 6) # => should be true
# two_sum?(arr, 10) # => should be false

# p two_sum?(arr, 15)
# two_sum?
# Given an array of unique integers and a target sum, determine whether any two integers in the array sum to that amount.

def windowed_max_range(arr, size)
    current_max_range = nil
    windows_arr = []
    (arr.length - size + 1).times do |i|
        windows_arr << arr[i...i+size]
    end
    max_range,current_range = 0,0
    windows_arr.each do |sub_arr| 
        current_range = sub_arr.max - sub_arr.min
        if max_range < current_range
            max_range = current_range
        end
    end
    max_range
end

module ADT
    attr_reader :max, :min
    def size
        @queue.size
    end

    def empty?
        size == 0
    end

    def range
        @max - @min
    end
    
    def inspect
        @queue
    end

end

module MyQueue
    include ADT

    def enqueue(value)
        @queue.push(value)
        @max = value if value > @max
        @min = value if value < @min
    end

    def dequeue
        old = @queue.shift
        @min = @queue.min if old == @min
        @max = @queue.max if old == @max
    end

    def peek
        @queue[0]
    end

end

module MyStack
    include ADT

    def push(value)
        @queue.push(value)
        @max = value if value > @max
        @min = value if value < @min
    end

    def pop
        old = @queue.pop
        @min = @queue.min if old == @min
        @max = @queue.max if old == @max
    end

    def peek
        @queue[-1]
    end

end

class StackQueue 
    include MyStack
    include MyQueue

    def initialize(value)
        @value = value
        @queue = [value]
        @max = value
        @min = value
    end

    def get_reverse_stack
        stack = []
        q = @queue.dup
        while !q.empty?
            stack.push(q.pop)
        end
        stack
    end

end





def windowed_max_range(array, window_size)
    # sq = StackQueue.new(arr.first)
    # for i in 1...size
    #     sq.push(arr[i])
    # end
    # for i in size...arr.length
    #     sq.enqueue(arr[i])
    #     sq.dequeue
    # end

    queue = StackQueue.new(array.first)
    best_range = nil

    array.each_with_index do |el, i|
        queue.enqueue(el)
        queue.dequeue if queue.size > window_size

        if queue.size == window_size
        current_range = queue.max - queue.min
        best_range = current_range if !best_range || current_range > best_range
        end
    end

    best_range

    
end

p windowed_max_range([1, 0, 2, 5, 4, 8], 2) # == 4 # [4, 8]
p windowed_max_range([1, 0, 2, 5, 4, 8], 3) #== 5 # [0, 2, 5]
p windowed_max_range([1, 0, 2, 5, 4, 8], 4) #== 6 # [2, 5, 4, 8]
p windowed_max_range([1, 3, 2, 5, 4, 8], 5) #== 6 # [3, 2, 5, 4, 8]