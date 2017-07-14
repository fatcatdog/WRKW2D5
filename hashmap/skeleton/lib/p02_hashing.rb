class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.inject(0) do |acc, el|
      acc = acc.hash ^ el.hash
    end
  end
end

class String
  def hash
    self.chars.inject(0) do |acc, el|
      acc = acc.hash ^ el.ord.hash
    end
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.sort.inject(0) do |acc, el|
      acc = acc.hash ^ el.hash
    end
  end
end
