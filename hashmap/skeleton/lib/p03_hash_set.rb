require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def hash_key(key)
    case key
    when Integer
    key.hash
    when String
    key.chars.inject(0) do |acc, el|
        acc = acc.hash ^ el.ord.hash
      end
    when Array
    key.inject(0) do |acc, el|
        acc = acc.hash ^ el.hash
      end
    when Hash
    key.sort.inject(0) do |acc, el|
        acc = acc.hash ^ el.hash
      end
    when Symbol
      key.to_s.chars.inject(0) do |acc, el|
          acc = acc.hash ^ el.ord.hash
        end
    end
  end

  def insert(key)

    hash_key = hash_key(key)
    @store[hash_key % num_buckets] << key unless include?(key)
    @count += 1
      if count == num_buckets
        resize!
      end

  end

  def remove(key)
    hash_key = hash_key(key)
    if include?(key)
      @store[hash_key % num_buckets].delete(key)
      @count -= 1
    end
  end

  def include?(key)
    hash_key = hash_key(key)
    @store[hash_key % num_buckets].include?(key)
  end
  private

  def [](key)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    numbers = @store.select {|el| el.size > 0}

    num_buckets = @store.length * 2
    resized_arr = []
    while resized_arr.size < (@store.length * 2 )
      resized_arr << []
    end
    @store = resized_arr
    numbers.each do |num|
      insert(num)
    end
    @store
  end
end
