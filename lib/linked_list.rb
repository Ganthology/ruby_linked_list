require_relative './node'

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @tail.nil?
      @tail = Node.new(value)
      @head = @tail
    else
      old_tail = @tail
      @tail = Node.new(value)
      old_tail.next_node = @tail
    end
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      @head = Node.new(value, @head)
    end
  end

  def size
    size = 0
    current_node = @head
    until current_node.next_node.nil?
      size += 1
      current_node = current_node.next_node
    end
    size
  end

  def at(index)
    cur_index = 0
    current_node = @head
    until cur_index == index
      cur_index += 1
      current_node = current_node.next_node
    end
    current_node
  end

  def pop
    popped = @tail
    current_node = current.next_node until current_node.next_node == @tail
    @tail = current_node.next_node(nil)
    popped
  end

  def contains?(value)
    until current_node.value == value
      return false if current_node.next_node.nil?

      current_node = current_node.next_node
    end
    true
  end

  def find(value)
    index = 0
    until current_node.value == value
      return nil if current_node.next_node.nil?

      current_node = current_node.next_node
      index += 1
    end
    index
  end

  def to_s
    # head > next value > tail > nil
    # while next value != nil
    current_node = @head
    output = @head.value.to_s
    until current_node.value.nil?
      current_node = current.next_node
      output << current_node.next_node.value.to_s
    end
    output
  end
end
