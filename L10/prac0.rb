Cell = Struct.new(:data, :next)
q = Cell.new(1, Cell.new(2, Cell.new(3, nil)))
p q # => #<struct Cell data=1, next=#<struct Cell data=2, next=#<struct Cell data=3, next=nil>>>

p q.data # => 1
p q.next.data # => 2
p q.next.next.data # => 3

s = Cell.new(1, nil)
n1 = Cell.new("A", nil)
n2 = Cell.new("B", nil)
n3 = Cell.new("C", nil)

s.next = n1
n1.next = n2
n2.next = n3
n3.next = s

$pointer = s

12.times do
    puts $pointer.data
    $pointer = $pointer.next
end

# =>
=begin
1
A
B
C
1
A
B
C
1
A
B
C
=end

# 2つめは置き方を変えただけで上記qと変わらない
