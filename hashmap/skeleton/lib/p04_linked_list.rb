require "byebug"

class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
attr_reader :head, :tail
  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
   @tail.prev
  end

  def last
    @head.next
  end

  def empty?
    return true if @head.next == @tail
    false
  end

  def get(key)
    return @head.next.val if @head.next.key == key
    current = @head.next
    until current.next.key == nil
      return current.next.val if current.next.key == key
      current = current.next
    end
    nil
  end

  def include?(key)
      return true if @head.next.key == key
      current = @head.next
    until current.next.key == nil
      return true if current.next.key == key
      current = current.next
    end
    false
  end

  def append(key, val)
    current = Link.new(key, val)
    if empty?
      current.next = @tail
      current.prev = @head
      @head.next = current
      @tail.prev = current
    else
      @head.next.prev = current
      current.next = @head.next
      @head.next = current
      current.prev = @head
    end
  end

  def update(key, val)
      return @head.next.val = val if @head.next.key == key
      current = @head.next
      until current.next == nil || current.next.key == nil
        return current.next.val = val if current.next.key == key
        current = current.next
      end
  end

  def remove(key)
    if @head.next.key == key
      current = @head.next
    else
      current = @head.next
      until current.next == nil || current.next.key == nil
        if current.next.key == key
          current = current.next
          break

        end
        current = current.next
      end
    end
    if current != nil
      current.prev.next = current.next
      current.next.prev = current.prev
    end
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
