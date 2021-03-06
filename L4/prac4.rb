# a 階乗

# fact(5)
# └-> 5 * fact(4)
# 		└-> 4 * fact(3)
# 				└-> 3 * fact(2)
# 						└-> 2 * fact(1)
# 								└-> 1

def fact(n)
	return n > 1 ? n * fact(n-1) : 1
end

p fact(5) # => 120

# b フィボナッチ数列

# fib(5)
# └-> fib(4)
# 	└-> fib(3)
# 		└-> fib(2)
# 			└-> fib(1)
# 				└-> 1
# 			+
# 			└-> fib(0)
# 				└-> 1
# 		+
# 		└-> fib(1)
# 			└-> 1
# 	+
# 	└-> fib(2)
# 		└-> fib(1)
# 			└-> 1
# 		+
# 		└-> fib(0)
# 			└-> 1
# +
# └-> fib(3)
# 	└-> fib(2)
# 		└-> fib(1)
# 			└-> 1
# 		+
# 		└-> fib(0)
# 			└-> 1
# 	+
# 	└-> fib(1)
# 		└-> 1

def fib(n) # fib[i]という配列に入れる体を想定して0始まり
	return n > 1 ? fib(n-1) + fib(n-2) : 1
end

for i in 0..20
	p fib(i)
end
# =>
# 1
# 1
# 2
# 3
# 5
# 8
# 13
# 21
# 34
# 55
# 89
# 144
# 233
# 377
# 610
# 987
# 1597
# 2584
# 4181
# 6765
# 10946

# c 組み合わせ

# comb(5, 3)
# └-> comb(4, 3)
# 	└-> comb(3, 3)
# 		└-> 1
# 	+
# 	└-> comb(3, 2)
# 		└-> comb(2, 2)
# 			└-> 1
# 		+
# 		└-> comb(2, 1)
# 			└-> comb(1, 1)
# 				└-> 1
# 			+
# 			└-> comb(1, 0)
# 				└-> 1
# +
# └-> comb(4, 2)
# 	└-> comb(3, 2)
# 		└-> comb(2, 2)
# 			└-> 1
# 		+
# 		└-> comb(2, 1)
# 			└-> comb(1, 1)
# 				└-> 1
# 			+
# 			└-> comb(1, 0)
# 				└-> 1
# 	+
# 	└-> comb(3, 1)
# 		└-> comb(2, 1)
# 			└-> comb(1, 1)
# 				└-> 1
# 			+
# 			└-> comb(1, 0)
# 				└-> 1
# 		+
# 		└-> comb(2, 0)
# 			└-> 1

def comb(n, r)
	return (r == 0 or r == n) ? 1 : comb(n-1, r) + comb(n-1, r-1)
end

for i in 1..10
	for j in 0..i
		puts "#{i}C#{j} = #{comb(i, j)}"
	end
end
# =>
# 1C0 = 1
# 1C1 = 1
# 2C0 = 1
# 2C1 = 2
# 2C2 = 1
# 3C0 = 1
# 3C1 = 3
# 3C2 = 3
# 3C3 = 1
# 4C0 = 1
# 4C1 = 4
# 4C2 = 6
# 4C3 = 4
# 4C4 = 1
# 5C0 = 1
# 5C1 = 5
# 5C2 = 10
# 5C3 = 10
# 5C4 = 5
# 5C5 = 1
# 6C0 = 1
# 6C1 = 6
# 6C2 = 15
# 6C3 = 20
# 6C4 = 15
# 6C5 = 6
# 6C6 = 1
# 7C0 = 1
# 7C1 = 7
# 7C2 = 21
# 7C3 = 35
# 7C4 = 35
# 7C5 = 21
# 7C6 = 7
# 7C7 = 1
# 8C0 = 1
# 8C1 = 8
# 8C2 = 28
# 8C3 = 56
# 8C4 = 70
# 8C5 = 56
# 8C6 = 28
# 8C7 = 8
# 8C8 = 1
# 9C0 = 1
# 9C1 = 9
# 9C2 = 36
# 9C3 = 84
# 9C4 = 126
# 9C5 = 126
# 9C6 = 84
# 9C7 = 36
# 9C8 = 9
# 9C9 = 1
# 10C0 = 1
# 10C1 = 10
# 10C2 = 45
# 10C3 = 120
# 10C4 = 210
# 10C5 = 252
# 10C6 = 210
# 10C7 = 120
# 10C8 = 45
# 10C9 = 10
# 10C10 = 1

# d 2進数

# binary(5)
# └-> binary(2) + "1"
# 	└-> binary(1) + "0"
# 		└-> "1"

def binary(n)
	if n <= 1 then return n.to_s end
	return n % 2 == 0 ? binary(n/2) + "0" : binary(n/2) + "1"
end

for i in 0..10
	p binary(i)
end
# =>
# "0"
# "1"
# "10"
# "11"
# "100"
# "101"
# "110"
# "111"
# "1000"
# "1001"
# "1010"