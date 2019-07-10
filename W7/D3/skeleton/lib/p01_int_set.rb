class MaxIntSet
  attr_reader :store
  def initialize(max)
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" unless is_valid?(num)
    @store[num] = true
    true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    num <= @store.length && num > 0
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[num % num_buckets] = true
  end

  def remove(num)
    @store[num % num_buckets] = nil
  end

  def include?(num)
    @store[num % num_buckets] == true
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if num_buckets == @count
    unless include?(num)
      @store[num % num_buckets] = num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      @store[num % num_buckets] = false
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets] == num
  end

  def inspect
    @store
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_copy = @store
    @store = Array.new(num_buckets * 2)
    @count = 0
    store_copy.each{|ele| insert(ele)}
  end

  
end
