# おまけ 2: blockを使用して数値積分を定義しなおす

def integ_bySimp(a, b, n=1000, &f)
	dx = (b - a).to_f / n
	s = 0.0
	n.times do |i|
		y_L = yield(a + i * dx) # 左端
		y_R = yield(a + (i + 1) * dx) # 右端
		y_C = yield(a + (i + 1/2.0) * dx) # 中央値
		s += ((y_L + 4*y_C + y_R) / 6.to_f ) * dx
	end
	return s
end

pi = 4 * integ_bySimp(0, 1, 10000000) do |x|
    Math::sqrt(1 - x**2)
end

p pi

# 数値微分を使用してニュートン法を考えてみる

def d(x, dx, &f)
    a = (yield(dx+x) - yield(x)) / dx
    b = (yield(x) - yield(x-dx)) / dx
    return (a+b) / 2.to_f
end

r = d(5, 10**(-5)) do |x|
    x**2 - 2
end

p r # => 10.0

r = d(5, 10**(-5)) do |x|
    x**3 - 2*x
end

p r # => 73.0000000001

def newton(a, dx, acc, &f)
    res = a/2.0
    pre_res = 0
    while ((res*(10**acc)).floor) != ((pre_res*(10**acc)).floor) do
        pre_res = res
		res = pre_res - yield(pre_res, a)/d(pre_res, dx, &f).to_f
    end
    return ((res*(10**acc)).floor) / (10**acc).to_f
end

def sqrt_byN(a, acc=5)
    if a < 0 then raise ArgumentError.new(a), "複素数になります。" end
    return newton(a, 10**(-5), acc) do |x|
        x**2 - a
    end
end

puts sqrt_byN(4) # => 2.0
puts sqrt_byN(2) # => 1.41421
puts sqrt_byN(2, 10) # => 1.4142135623
puts sqrt_byN(9) # => 3.0
puts sqrt_byN(7) # => 2.64575

__END__

3.1415926535853904
10.0
73.0000000001
2.0
1.41421
1.4142135623
3.0
2.64575