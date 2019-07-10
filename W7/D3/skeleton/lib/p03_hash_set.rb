class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if num_buckets == @count
    hash_val = key.hash
    bucket_idx = hash_val % num_buckets

    if !include?(key)
      @store[bucket_idx] << key
      @count += 1
    end
    # p "inserted #{key} store: #{@store}"
  end

  def include?(key)
    @store.any?{ |sub| sub.include?(key) }
  end

  def remove(key)
    if include?(key)
      hash_val = key.hash
      bucket_idx = hash_val % num_buckets
      @store[bucket_idx].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    store_copy = @store
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    store_copy.each{|ele| insert(ele)}
  end
end
