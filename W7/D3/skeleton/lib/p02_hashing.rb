class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    hash = 0
    self.each do |ele|
      hash += ele.hash
      hash = hash.hash
    end
    hash
  end
end

class String
  def hash
    hash = 0
    self.each_char do |c|
        hash += c.ord.hash
        hash = hash.hash
    end
    hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    keys = self.keys.sort
    values = self.values.sort
    hash = 0
    keys.each{ |ele| hash += ele.hash}
    values.each{ |ele| hash += ele.hash}
    hash
  end
end
