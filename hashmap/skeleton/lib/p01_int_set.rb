class MaxIntSet
  def initialize(max)
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" if is_valid?(num) == false
    @store[num] = true if @store[num] == false

  end

  def remove(num)
    @store[num] = false if  @store[num] == true
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
    0 <= num && num <= @store.length - 1
  end

  def validate!(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { []}
  end

  def insert(num)
    @store[num % 20] << num
  end

  def remove(num)
    @store[num % 20].delete(num)

  end

  def include?(num)
    @store[num % 20].include?(num)


  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
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
    @store[num % num_buckets] << num unless include?(num)
    @count += 1
    if count == num_buckets
      resize!
    end

  end

  def remove(num)
    if include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end
  private

  def [](num)
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
    numbers.flatten.each do |num|
      insert(num)
    end
    @store
  end
end
