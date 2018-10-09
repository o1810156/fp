# c
def rec(a)
    return 1/(a.to_f)
end

puts rec(5) # => 0.2

# d
# for文を使用する方法
def exp(x, e)
    r = 1
    for _ in 1..e do
        r *= x
    end
    return r
end

puts exp(2, 8) # => 256
puts exp(2, 6) # => 64
puts exp(2, 7) # => 128

# 再帰呼び出しを使用する方法
def exp_r(x, e)
    e -= 1
    if e > 0 then
        return x * exp_r(x, e)
    else
        return x
    end
end

puts exp_r(2, 8) # => 256
puts exp_r(2, 6) # => 64
puts exp_r(2, 7) # => 128

# e
def cone(r, h)
    return (Math::PI * (r**2) * h)/3.0
end

puts cone(1, 1) # => 1.0471975511965976
puts cone(2, 3) # => 12.566370614359172

# f
# 折角なのでニュートン法で実装してみた。
#
# f'(x_1) = lim_{x \arr x_1} \frac{f(x) - f(x_1)}{x - x_1} # 微分の定義
# lim を一時的に存在しないものとすると
#
# f'(x_1)(x - x1) = f(x) - f(x_1)
# f(x) = f'(x_1)(x - x_1) + f(x_1)
# f(x) = 0 となるxをx = x_2 とすると
#
# f(x_2) = f'(x_1)(x_2 - x_1) + f(x_1) = 0
# f'(x_1)(x_2 - x_1) = -f(x_1)
# x_2 = x_1 - \frac{f(x_1)}{f'(x_1)}
#
# x_n = x_{n-1} - \frac{f(x_{n-1})}{f'(x_{n-1})} = C
# この漸化式を解くことで近似値が算出される
#
# \sqrt{a} は関数f(x) = x^2 - a の解
# f'(x) = 2x
#
# よって漸化式は
# x_n = x_{n-1} - \frac{x_{n-1}^2 - a}{2x_{n-1}}

def sqrt_byN(a, acc=5) # SQuare RooT by Newton method
    if a < 0 then raise ArgumentError.new(a), "複素数になります。" end
    res = a/2.0
    pre_res = -1
    while ((res*(10**acc)).floor) != ((pre_res*(10**acc)).floor) do
        pre_res = res
		res = pre_res - (pre_res**2 - a)/(2*pre_res).to_f
    end
    return ((res*(10**acc)).floor) / (10**acc).to_f
end

puts sqrt_byN(4) # => 2.0
puts sqrt_byN(2) # => 1.41421
puts sqrt_byN(2, 10) # => 1.4142135623
puts sqrt_byN(9) # => 3.0
puts sqrt_byN(7) # => 2.64575
# puts sqrt_byN(-1)
# => prac_1_3_2.rb:68:in `sqrt_byN': 複素数になります。 (ArgumentError)
#	from prac_1_3_2.rb:83:in `<main>'

# g
# fを用いて数学的な定義により絶対値を返す関数を書いた。
# |n| = \sqrt{a^n}
def abs(n)
    return sqrt_byN(n*n)
end

puts abs(1) # => 1.0
puts abs(-2) # => 2.0
puts abs(-1.234) # => 1.234
# puts abs(0)
# => prac_1_3_2.rb:71:in `floor': NaN (FloatDomainError)
#         from prac_1_3_2.rb:71:in `sqrt_byN'
#         from prac_1_3_2.rb:91:in `abs'
#         from prac_1_3_2.rb:97:in `<main>'
# ↑ sqrt_byNにおいて0がエッジケースであった...折角?なので残す

# 上記の方法ではエッジケースに対応できず、
# このエッジケースに対応するために
# if文を増やすぐらいなら(いやsqrtを修正しろよ笑)、
# if文でabsを記述したほうが楽であるから、以下のように実装しなおした

def abs(n)
    if n < 0 then
        return -n
    else
        return n
    end
end

puts abs(1) # => 1
puts abs(-2) # => 2
puts abs(-1.234) # => 1.234
puts abs(0) # => 0

# この課題のように場合によっては数学的な手法を取らないほうがいいときがあることが観測できる。

# おまけ: 修正後のsqrt_byN

def sqrt_byN(a, acc=5)
    if a == 0 then return 0 end
    if a < 0 then raise ArgumentError.new(a), "複素数になります。" end
    res = a/2.0
    pre_res = -1
    while ((res*(10**acc)).floor) != ((pre_res*(10**acc)).floor) do
        pre_res = res
		res = pre_res - (pre_res**2 - a)/(2*pre_res).to_f
    end
    return ((res*(10**acc)).floor) / (10**acc).to_f
end

puts sqrt_byN(4) # => 2.0
puts sqrt_byN(2) # => 1.41421
puts sqrt_byN(2, 10) # => 1.4142135623
puts sqrt_byN(9) # => 3.0
puts sqrt_byN(7) # => 2.64575
puts sqrt_byN(0) # => 0