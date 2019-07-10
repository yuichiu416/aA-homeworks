require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].each{ |node| return true if node.key == key }
    false
  end

  def set(key, val)
    resize! if num_buckets == @count
    if include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
    end
  end

  def get(key)
      @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].each{ |node| node.remove if node.key == key }
    @count -= 1
  end

  def each(&prc)
    @store.each { |list| list.each { |node| prc.call(node.key, node.val)} }
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    store_copy = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0
    store_copy.each{|list| list.each { |node| set(node.key, node.val)}}
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
