class Ratio
	def initialize(a, b = 1)
		@a = a
		@b = b
		if b == 0 # 分母が0なら
			@a = 1 # aを1とする
			return
		end
		if a == 0 # 分子が0なら
			@b = 1
			return
		end
		if b < 0
			@a = -a
			@b = -b
		end
		g = gcd(a.abs, b.abs); @a = @a/g; @b = @b/g
	end

	def getDivisor
		return @b
	end
	def getDividend
		return @a
	end

	def to_s
		if @b == 1
			return "#{@a}"
		else
			return "#{@a}/#{@b}"
		end
	end

	def +(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*d + @b*c, @b*d) # a/b+c/d = (ad+bc)/bd
	end

	def -(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*d - @b*c, @b*d) # a/b-c/d = (ad-bc)/bd
	end

	def *(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*c, @b*d) # a/b * c/d = a*c / b*d
	end

	def /(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*d, @b*c) # a/b / c/d = a*d / b*c
	end

	def **(n)
		return Ratio.new(@a**n, @b**n)
	end

	def gcd(x, y) # 第3回 演習2 参考
		while true do
			if x > y
				x = x % y
				if x == 0
					return y
				end
			else
				y = y % x
				if y == 0
					return x
				end
			end
		end
	end
end

x = Ratio.new(15, 3)
puts x # => 5

a = Ratio.new(3, 5)
b = Ratio.new(8, 7)

puts "#{a} + #{b} = #{a + b}"
puts "#{a} - #{b} = #{a - b}"
puts "#{a} * #{b} = #{a * b}"
puts "#{a} / #{b} = #{a / b}"
puts "#{a} ^ 5 = #{a**5}"

# =>
# 3/5 + 8/7 = 61/35
# 3/5 - 8/7 = -19/35
# 3/5 * 8/7 = 24/35
# 3/5 / 8/7 = 21/40
# 3/5 ^ 5 = 243/3125

puts "######"

c = Ratio.new(3, 5)
d = Ratio.new(2, 5)

puts "#{c} + #{d} = #{c + d}"
puts "#{c} - #{d} = #{c - d}"
puts "#{c} * #{d} = #{c * d}"
puts "#{c} / #{d} = #{c / d}"
puts "#{c} ^ 5 = #{c**5}"

# =>
# 3/5 + 2/5 = 1
# 3/5 - 2/5 = 1/5
# 3/5 * 2/5 = 6/25
# 3/5 / 2/5 = 3/2
# 3/5 ^ 5 = 243/3125

puts "######"

# 浮動小数点では正確に行えない「実用的な」計算

puts "10**10 + 1e-10 = #{10**10 + 1e-10}"
puts "Ratio.new(10**10, 1) + Ratio.new(1, 10**10) = #{Ratio.new(10**10, 1) + Ratio.new(1, 10**10)}"

# =>
# 10**10 + 1e-10 = 10000000000.0
# Ratio.new(10**10, 1) + Ratio.new(1, 10**10) = 100000000000000000001/10000000000