def integ1(a, b, n)
	dx = (b - a).to_f / n
	s = 0.0
	x = a
	# count = 0
	while x < b do
		y = x**2
		s += y * dx
		x += dx
		# count += 1
		# puts "count = #{count} x = #{x}"
	end
	return s 
end

puts "integ1(1, 10, 100)   = #{integ1(1, 10, 100)}"
puts "integ1(1, 10, 1000)  = #{integ1(1, 10, 1000)}" 
puts "integ1(1, 10, 10000) = #{integ1(1, 10, 10000)}"
# =>
# integ1(1, 10, 100)   = 337.5571499999994
# integ1(1, 10, 1000)  = 332.55462150000733
# integ1(1, 10, 10000) = 333.04545121491196

# whileで実装したのが原因

def integ2(a, b, n)
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		x = a + i * dx
		y = x**2
		s += y * dx
		# puts "i = #{i} x = #{x}"
	end
	return s 
end

puts "integ2(1, 10, 100)   = #{integ2(1, 10, 100)}"
puts "integ2(1, 10, 1000)  = #{integ2(1, 10, 1000)}"
puts "integ2(1, 10, 10000) = #{integ2(1, 10, 10000)}"
# =>
# integ2(1, 10, 100)   = 328.5571499999999
# integ2(1, 10, 1000)  = 332.5546214999998
# integ2(1, 10, 10000) = 332.9554512149995

def integ(f, a, b, n=1000)
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		x = a + i * dx
		y = f.call(x)
		s += y * dx
	end
	return s
end

# 円周率計算
puts "4 * integ(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100000) = #{4 * integ(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100000)}"
# => 4 * integ(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100000) = 3.1416126164019564

# 減少関数に関する考察
puts "integ(lambda {|x| -x**2+100}, 0, 10, 10)     = #{integ(lambda {|x| -x**2+100}, 0, 10, 10)}"
puts "integ(lambda {|x| -x**2+100}, 0, 10, 100)    = #{integ(lambda {|x| -x**2+100}, 0, 10, 100)}"
puts "integ(lambda {|x| -x**2+100}, 0, 10, 1000)   = #{integ(lambda {|x| -x**2+100}, 0, 10, 1000)}"
puts "integ(lambda {|x| -x**2+100}, 0, 10, 10000)  = #{integ(lambda {|x| -x**2+100}, 0, 10, 10000)}"
puts "integ(lambda {|x| -x**2+100}, 0, 10, 100000) = #{integ(lambda {|x| -x**2+100}, 0, 10, 100000)}"
# =>
# integ(lambda {|x| -x**2+100}, 0, 10, 10)     = 715.0
# integ(lambda {|x| -x**2+100}, 0, 10, 100)    = 671.6499999999999
# integ(lambda {|x| -x**2+100}, 0, 10, 1000)   = 667.1664999999988
# integ(lambda {|x| -x**2+100}, 0, 10, 10000)  = 666.7166650000001
# integ(lambda {|x| -x**2+100}, 0, 10, 100000) = 666.6716666500104

# 正しい答え 666.6666666.... に大きいほうから近づいていることが観測できる。

# 演習3

# 右端で計算させる
def integ_right(f, a, b, n=1000)
	dx = (b - a).to_f / n
	s = 0.0
	for i in 1..n # 0 ~ n-1 ではなく、1 ~ n で計算させる
		x = a + i * dx
		y = f.call(x)
		s += y * dx
	end
	return s
end

# 増加関数では値が大きいほうから近づき、
puts "integ_right(lambda {|x| x**2}, 0, 10, 10)     = #{integ_right(lambda {|x| x**2}, 0, 10, 10)}"
puts "integ_right(lambda {|x| x**2}, 0, 10, 100)    = #{integ_right(lambda {|x| x**2}, 0, 10, 100)}"
puts "integ_right(lambda {|x| x**2}, 0, 10, 1000)   = #{integ_right(lambda {|x| x**2}, 0, 10, 1000)}"
puts "integ_right(lambda {|x| x**2}, 0, 10, 10000)  = #{integ_right(lambda {|x| x**2}, 0, 10, 10000)}"
puts "integ_right(lambda {|x| x**2}, 0, 10, 100000) = #{integ_right(lambda {|x| x**2}, 0, 10, 100000)}"
# =>
# integ_right(lambda {|x| x**2}, 0, 10, 10)     = 385.0
# integ_right(lambda {|x| x**2}, 0, 10, 100)    = 338.34999999999997
# integ_right(lambda {|x| x**2}, 0, 10, 1000)   = 333.8334999999999
# integ_right(lambda {|x| x**2}, 0, 10, 10000)  = 333.3833349999996
# integ_right(lambda {|x| x**2}, 0, 10, 100000) = 333.33833335000037

# 減少関数では値が小さいほうから近づくのが確認できる。
puts "integ_right(lambda {|x| -x**2+100}, 0, 10, 10)     = #{integ_right(lambda {|x| -x**2+100}, 0, 10, 10)}"
puts "integ_right(lambda {|x| -x**2+100}, 0, 10, 100)    = #{integ_right(lambda {|x| -x**2+100}, 0, 10, 100)}"
puts "integ_right(lambda {|x| -x**2+100}, 0, 10, 1000)   = #{integ_right(lambda {|x| -x**2+100}, 0, 10, 1000)}"
puts "integ_right(lambda {|x| -x**2+100}, 0, 10, 10000)  = #{integ_right(lambda {|x| -x**2+100}, 0, 10, 10000)}"
puts "integ_right(lambda {|x| -x**2+100}, 0, 10, 100000) = #{integ_right(lambda {|x| -x**2+100}, 0, 10, 100000)}"
# =>
# integ_right(lambda {|x| -x**2+100}, 0, 10, 10)     = 615.0
# integ_right(lambda {|x| -x**2+100}, 0, 10, 100)    = 661.6499999999999
# integ_right(lambda {|x| -x**2+100}, 0, 10, 1000)   = 666.1664999999988
# integ_right(lambda {|x| -x**2+100}, 0, 10, 10000)  = 666.6166650000001
# integ_right(lambda {|x| -x**2+100}, 0, 10, 100000) = 666.6616666500104

# a

# 両端の平均を使用する
def integ_ave(f, a, b, n=1000) # integral average
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		x = a + i * dx
		# y_1 = f.call(x)
		# y_2 = f.call(x + dx)
		# y = (y_1 + y_2) / 2.to_f
		y = (f.call(x) + f.call(x + dx)) / 2.to_f
		s += y * dx
	end
	return s
end

# 増加関数
puts "integ_ave(lambda {|x| x**2}, 0, 10, 10)     = #{integ_ave(lambda {|x| x**2}, 0, 10, 10)}"
puts "integ_ave(lambda {|x| x**2}, 0, 10, 100)    = #{integ_ave(lambda {|x| x**2}, 0, 10, 100)}"
puts "integ_ave(lambda {|x| x**2}, 0, 10, 1000)   = #{integ_ave(lambda {|x| x**2}, 0, 10, 1000)}" 
puts "integ_ave(lambda {|x| x**2}, 0, 10, 10000)  = #{integ_ave(lambda {|x| x**2}, 0, 10, 10000)}"
puts "integ_ave(lambda {|x| x**2}, 0, 10, 100000) = #{integ_ave(lambda {|x| x**2}, 0, 10, 100000)}"
# =>
# integ_ave(lambda {|x| x**2}, 0, 10, 10)     = 335.0
# integ_ave(lambda {|x| x**2}, 0, 10, 100)    = 333.35
# integ_ave(lambda {|x| x**2}, 0, 10, 1000)   = 333.3335000000001
# integ_ave(lambda {|x| x**2}, 0, 10, 10000)  = 333.3333349999998
# integ_ave(lambda {|x| x**2}, 0, 10, 100000) = 333.3333333499998

# 減少関数
puts "integ_ave(lambda {|x| -x**2+100}, 0, 10, 10)     = #{integ_ave(lambda {|x| -x**2+100}, 0, 10, 10)}"
puts "integ_ave(lambda {|x| -x**2+100}, 0, 10, 100)    = #{integ_ave(lambda {|x| -x**2+100}, 0, 10, 100)}"
puts "integ_ave(lambda {|x| -x**2+100}, 0, 10, 1000)   = #{integ_ave(lambda {|x| -x**2+100}, 0, 10, 1000)}"
puts "integ_ave(lambda {|x| -x**2+100}, 0, 10, 10000)  = #{integ_ave(lambda {|x| -x**2+100}, 0, 10, 10000)}"
puts "integ_ave(lambda {|x| -x**2+100}, 0, 10, 100000) = #{integ_ave(lambda {|x| -x**2+100}, 0, 10, 100000)}"
# =>
# integ_ave(lambda {|x| -x**2+100}, 0, 10, 10)     = 665.0
# integ_ave(lambda {|x| -x**2+100}, 0, 10, 100)    = 666.65
# integ_ave(lambda {|x| -x**2+100}, 0, 10, 1000)   = 666.6665000000003
# integ_ave(lambda {|x| -x**2+100}, 0, 10, 10000)  = 666.6666649999989
# integ_ave(lambda {|x| -x**2+100}, 0, 10, 100000) = 666.6666666499943

# 精度の向上はよく見られた。
# 挙動は今回は右端で計算した場合と等しく
# 作図して考えることで
# 上に凸だと実際の値より小さく、
# 下に凸だと実際の値より大きいことがわかる。

# b

# 両端の中央を使用する
def integ_dubSide(f, a, b, n=1000) # integral double sides
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		# x_1 = a + i * dx # 左端
		# x_2 = a + (i + 1) * dx # 右端
		# x = (x_1 + x_2) / 2.to_f
		x = a + (i + 1/2.0) * dx
		y = f.call(x)
		s += y * dx
	end
	return s
end

# 増加関数
puts "integ_dubSide(lambda {|x| x**2}, 0, 10, 10)     = #{integ_dubSide(lambda {|x| x**2}, 0, 10, 10)}"
puts "integ_dubSide(lambda {|x| x**2}, 0, 10, 100)    = #{integ_dubSide(lambda {|x| x**2}, 0, 10, 100)}"
puts "integ_dubSide(lambda {|x| x**2}, 0, 10, 1000)   = #{integ_dubSide(lambda {|x| x**2}, 0, 10, 1000)}" 
puts "integ_dubSide(lambda {|x| x**2}, 0, 10, 10000)  = #{integ_dubSide(lambda {|x| x**2}, 0, 10, 10000)}"
puts "integ_dubSide(lambda {|x| x**2}, 0, 10, 100000) = #{integ_dubSide(lambda {|x| x**2}, 0, 10, 100000)}"
# =>
# integ_dubSide(lambda {|x| x**2}, 0, 10, 10)     = 332.5
# integ_dubSide(lambda {|x| x**2}, 0, 10, 100)    = 333.3250000000001
# integ_dubSide(lambda {|x| x**2}, 0, 10, 1000)   = 333.33324999999996
# integ_dubSide(lambda {|x| x**2}, 0, 10, 10000)  = 333.33333250000044
# integ_dubSide(lambda {|x| x**2}, 0, 10, 100000) = 333.3333333249999

# 減少関数
puts "integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 10)     = #{integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 10)}"
puts "integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 100)    = #{integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 100)}"
puts "integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 1000)   = #{integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 1000)}"
puts "integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 10000)  = #{integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 10000)}"
puts "integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 100000) = #{integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 100000)}"
# =>
# integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 10)     = 667.5
# integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 100)    = 666.675
# integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 1000)   = 666.6667499999985
# integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 10000)  = 666.666667500001
# integ_dubSide(lambda {|x| -x**2+100}, 0, 10, 100000) = 666.6666666750028

# 平均のときと同じく
# 精度の向上はよく見られた。
# 挙動は今回は左端で計算した場合と等しく
# 作図して考えることで
# 上に凸だと実際の値より大きく、
# 下に凸だと実際の値より小さいことがわかる。

# c
#
# シンプソン公式というものがあるらしく、
# (右端 + 中央値*4 + 左端) / 6 の値を使うといいらしいので実装してみた

def integ_bySimp(f, a, b, n=1000) # integral by Simpson's rule
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		y_L = f.call(a + i * dx) # 左端
		y_R = f.call(a + (i + 1) * dx) # 右端
		y_C = f.call(a + (i + 1/2.0) * dx) # 中央値
		s += ((y_L + 4*y_C + y_R) / 6.to_f ) * dx
	end
	return s
end

# 増加関数
puts "integ_bySimp(lambda {|x| x**2}, 0, 10, 10)     = #{integ_bySimp(lambda {|x| x**2}, 0, 10, 10)}"
puts "integ_bySimp(lambda {|x| x**2}, 0, 10, 100)    = #{integ_bySimp(lambda {|x| x**2}, 0, 10, 100)}"
puts "integ_bySimp(lambda {|x| x**2}, 0, 10, 1000)   = #{integ_bySimp(lambda {|x| x**2}, 0, 10, 1000)}" 
puts "integ_bySimp(lambda {|x| x**2}, 0, 10, 10000)  = #{integ_bySimp(lambda {|x| x**2}, 0, 10, 10000)}"
puts "integ_bySimp(lambda {|x| x**2}, 0, 10, 100000) = #{integ_bySimp(lambda {|x| x**2}, 0, 10, 100000)}"
# =>
# integ_bySimp(lambda {|x| x**2}, 0, 10, 10)     = 333.3333333333333
# integ_bySimp(lambda {|x| x**2}, 0, 10, 100)    = 333.33333333333337
# integ_bySimp(lambda {|x| x**2}, 0, 10, 1000)   = 333.33333333333337
# integ_bySimp(lambda {|x| x**2}, 0, 10, 10000)  = 333.3333333333332
# integ_bySimp(lambda {|x| x**2}, 0, 10, 100000) = 333.3333333333337

# 減少関数
puts "integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 10)     = #{integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 10)}"
puts "integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 100)    = #{integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 100)}"
puts "integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 1000)   = #{integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 1000)}"
puts "integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 10000)  = #{integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 10000)}"
puts "integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 100000) = #{integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 100000)}"
# =>
# integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 10)     = 666.6666666666665
# integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 100)    = 666.6666666666664
# integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 1000)   = 666.6666666666677
# integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 10000)  = 666.6666666666666
# integ_bySimp(lambda {|x| -x**2+100}, 0, 10, 100000) = 666.6666666666598

# ものすごい良い精度で近似ができた。
# 実行結果を見る限り分割数を上げすぎないほうが精度がよいという不思議な点が見られた。
# 2次曲線で近似しているために、精度によっては完全に一致する時があるからかと考えられる。

puts "4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10)       = #{4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10)}"
puts "4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100)      = #{4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100)}"
puts "4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 1000)     = #{4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 1000)}"
puts "4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10000)    = #{4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10000)}"
puts "4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100000)   = #{4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100000)}"
puts "4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 1000000)  = #{4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 1000000)}"
puts "4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10000000) = #{4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10000000)}"
# =>
# 4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10)       = 3.136447064257202
# 4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100)      = 3.1414302491930215
# 4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 1000)     = 3.141587518912274
# 4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10000)    = 3.141592491220199
# 4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 100000)   = 3.1415926484552488
# 4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 1000000)  = 3.141592653427536
# 4 * integ_bySimp(lambda {|x| Math::sqrt(1 - x**2)}, 0, 1, 10000000) = 3.1415926535853904

# このように2次曲線ではない関数だとやはり精度を上げたほうが正確であることがわかる。