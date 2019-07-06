
# Build Main Method
def my_uniq(arr)
  hash = Hash.new(0)

  arr.each do |ele|
    hash[ele] += 1
  end
  
  hash.keys
end


# Build Main Method
def two_sum(arr)
  hash = {}
  ans = []

  arr.each_with_index do |ele, i|
    if hash[ele]
      ans.unshift([hash[ele], i])
    else
      hash[0 - ele] = i      
    end
  end 
  ans
end

def my_transpose(arr)
  for i in 0...arr.length
    for j in i...arr[i].length
      arr[i][j], arr[j][i] = arr[j][i], arr[i][j]
    end
  end
  arr
end

# rows = [
#     [0, 1, 2],
#     [3, 4, 5],
#     [6, 7, 8]
#   ]

# cols = [
#     [0, 3, 6],
#     [1, 4, 7],
#     [2, 5, 8]
#   ]


# Build Main Method
