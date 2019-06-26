# Problem 1: You have array of integers. Write a recursive solution to find the sum of the integers.

def sum(arr)
    return 0 if arr.length < 1
    arr[0] + sum(arr[1..-1])
end

p sum([1,2,3,4,5,6,7,8,9,10].shuffle) # 55


# Problem 2: You have array of integers. Write a recursive solution to determine whether or not the array contains a specific value.

def contain?(arr, key)
    return false if arr.length < 1
    arr[0] == key ? (return true) : (return contain?(arr[1..-1], key))
end

p contain?([1,3,5,7,9], 4) # false
# Problem 3: You have an unsorted array of integers. Write a recursive solution to count the number of occurrences of a specific value.

def count(arr, n)
    return 0 if arr.length < 1
    if arr[0] == n
        return 1 + count(arr[1..-1], n)
    else
        return count(arr[1..-1], n)
    end
end

p count([1,3,2,4,2,5,2], 2) # 3
# Problem 4: You have array of integers. Write a recursive solution to determine whether or not two adjacent elements of the array add to 12.

def add_to_12?(arr)
    return false if arr.length < 2
    if arr[0] + arr[1] == 12
        return true
    else
        return add_to_12?(arr[1..-1])
    end
end

p add_to_12?([1,3,5,7,9,11,13]) # true
# Problem 5: You have array of integers. Write a recursive solution to determine if the array is sorted.

def sorted?(arr)
    return false if arr.length < 1|| arr[0] > arr[1]
    return true if arr.length == 2
    return sorted?(arr[1..-1])  if arr[0] < arr[1]
end

p "sorted"
p sorted?([2,3,5,7,8]) # true
p sorted?([9,6,3,3,1]) # false
# Problem 6: Write a recursive function to reverse a string. Don't use any built-in #reverse methods!

def reverse(str)
    return "" if str.length == 0
    reverse(str[1..-1]) + str[0]
end

p reverse("test123") # "321tset"