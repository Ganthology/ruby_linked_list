require_relative './node'

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    if @tail.nil?
      @tail = Node.new(value, nil)
      @head = @tail
    else
      old_tail = @tail
      @tail = Node.new(value, nil)
      old_tail.next_node = @tail
    end
  end

  def prepend(value)
    if @head.nil?
      @head = Node.new(value, nil)
      @tail = @head
    else
      @head = Node.new(value, @head)
    end
  end

  def size
    return 0 if @head.nil?

    size = 1
    current_node = @head
    until current_node == @tail
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
      return Node.new(-1, nil) if current_node.nil?
    end
    current_node
  end

  def pop
    return nil if @head.nil?
    popped = @tail
    current_node = @head
    current_node = current_node.next_node until current_node.next_node == @tail
    current_node.next_node = nil
    @tail = current_node
    popped
  end

  def contains?(value)
    current_node = @head
    until current_node.value == value
      return false if current_node.next_node.nil?

      current_node = current_node.next_node
    end
    true
  end

  def find(value)
    index = 0
    current_node = @head
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
    return 'The list is empty' if @head.nil?
    current_node = @head
    output = @head.value.to_s
    until current_node == @tail
      current_node = current_node.next_node
      output << " -> #{current_node.value}"
    end
    output
  end

  def insert_at(value, index)
    # base case, index is 0, replace head
    if index.zero?
      temp = @head
      @head = Node.new(value, temp)
    elsif at(index).value.negative?
      puts 'The index is out of bounds'
    elsif at(index) == @tail
      temp = @tail
      @tail = Node.new(value, nil)
      temp.next_node = @tail
    else
      new_node = Node.new(value, at(index))
      before = at(index - 1)
      before.next_node = new_node
      new_node
    end
  end

  def remove_at(index)
    if index.zero?
      @head = @head.next_node
    elsif at(index).value.negative?
      puts 'The index is out of bounds'
    elsif at(index) == @tail
      @tail = at(index - 1)
      @tail.next_node = nil
    else
      at(index - 1).next_node = at(index + 1)
    end
  end
end

# demo code
list = LinkedList.new
# try the append method
(1..10).each do |i|
  list.append(i)
end
puts '0. should print 1 for head, 10 for tail'
puts "head = #{list.head.value}, tail = #{list.tail.value}"
# try the to_s method
puts '1. print the list, should print 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> 9 -> 10'
puts list.to_s

# try the size method
puts '2. try the size method, should print 10'
puts list.size

# try the pop method, last element is removed
list.pop
puts '3. last is popped, should print 9 as the tail value'
p list.tail.value

# try the prepend method, add to first element
puts '4. 0 is added to first, should print 0 as head value'
list.prepend(0)
p list.head.value

# try the at(index) method
puts '5i. should print 1 for index 1'
puts list.at(1).value
puts '5ii. should print -1 for index 11, not exist'
p list.at(11).value

# try the contains?(value) method
puts '6i. should print true for 1 exist'
puts list.contains?(1)
puts '6ii. should print false for 20 not exist'
puts list.contains?(20)

# try the find method
puts '7i. should print index 7 for value 7 node'
puts list.find(7)
puts '7ii. should print nil for 11 node that doesnt exist'
p list.find(11)

# try the insert_at method
puts '8i. should print -1 for index 0'
list.insert_at(-1, 0)
puts list.head.value
puts '8ii. should print 10 for index 10'
list.insert_at(10, 10)
puts list.tail.value
puts '8iii. should print error message for index 13'
list.insert_at(13, 13)

# try the remove_at(index) method
puts '9i. should print 0 for index 0'
list.remove_at(0)
puts list.head.value
puts '9ii. should print 9 for index 9'
list.remove_at(10)
puts list.at(9).value
