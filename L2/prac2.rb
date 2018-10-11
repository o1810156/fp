# a

def max(a, b)
    return a > b ? a : b
end

puts "max(1, 2) = #{max(1, 2)}" # => max(1, 2) = 2
puts "max(3, 5) = #{max(3, 5)}" # => max(3, 5) = 5
puts "max(Math::PI, 3) = #{max(Math::PI, 3)}" # => max(Math::PI, 3) = 3.141592653589793
puts "max(-5, 3) = #{max(-5, 3)}" # => max(-5, 3) = 3
puts "max(0, 3) = #{max(0, 3)}" # => max(0, 3) = 3

# b

def max(a, b, c)
	m = a
	if b > m then m = b end
	if c > m then m = c end
	return m
end

puts "max(1, 2, 3) = #{max(1, 2, 3)}" # => max(1, 2, 3) = 3
puts "max(2, 3, 1) = #{max(2, 3, 1)}" # => max(2, 3, 1) = 3
puts "max(3, 2, 1) = #{max(3, 2, 1)}" # => max(3, 2, 1) = 3

## 配列版

def max(arr)
	m = arr[0]
	for i in arr[1..-1] do
		if i > m then m = i end
	end
	return m
end

puts "max([1, 2]) = #{max([1, 2])}" # => max([1, 2]) = 2
puts "max([1, 2, 3]) = #{max([1, 2, 3])}" # => max([1, 2, 3]) = 3
puts "max([1, -2, 5, 3]) = #{max([1, -2, 5, 3])}" # => max([1, -2, 5, 3]) = 5
# puts "max(1, 2, 3) = #{max(1, 2, 3)}" # 上書きしたためにエラーになる
# =>
# prac2.rb:28:in `max': wrong number of arguments (3 for 1) (ArgumentError)
#	from prac2.rb:39:in `<main>'

## 可変長引数版

def max(*arr)
	m = arr[0]
	for i in arr[1..-1] do
		if i > m then m = i end
	end
	return m
end

puts "max(1, 2) = #{max(1, 2)}" # => max(1, 2) = 2
puts "max(1, 2, 3) = #{max(1, 2, 3)}" # => max(1, 2, 3) = 3
puts "max(1, -2, 5, 3) = #{max(1, -2, 5, 3)}" # => max(1, -2, 5, 3) = 5
puts "max([1, 5, 3, 2]) = #{max([1, 5, 3, 2])}" # => max([1, 5, 3, 2]) = [1, 5, 3, 2] # 正しい結果にならない
puts "max(*[1, 5, 3, 2]) = #{max(*[1, 5, 3, 2])}" # => max(*[1, 5, 3, 2]) = 5 # 展開して渡せば正しい結果となる

## 改良版

def max(*arr)
	if arr[0].class == Array then arr = arr[0] end
	m = arr[0]
	for i in arr[1..-1] do
		if i > m then m = i end
	end
	return m
end

puts "max(1, 3) = #{max(1, 3)}" # => max(1, 3) = 3
puts "max([1, 5, 3, 2]) = #{max([1, 5, 3, 2])}" # => max([1, 5, 3, 2]) = 5
puts "max(*[1, 5, 3, 2]) = #{max(*[1, 5, 3, 2])}" # => max(*[1, 5, 3, 2]) = 5

# すべて正しい結果となる

# c

def judge(x)
	if x > 0
		return "positive"
	elsif x < 0
		return "negative"
	end
	return "zero"
end

puts "1 is #{judge(1)}" # => 1 is positive
puts "2 is #{judge(2)}" # => 2 is positive
puts "-1 is #{judge(-1)}" # => -1 is negative
puts "0 is #{judge(0)}" # => 0 is zero
puts "10e-30 is #{judge(10e-30)}" # => 10e-30 is positive
puts "-10e-60 is #{judge(-10e-60)}" # => -10e-60 is negative


