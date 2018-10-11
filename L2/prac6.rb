# 原理

# nが素数であるということは `2..n-1` までの整数でnは割り切れないということである。
# であるから `2..n-1` でループを回せばよいが、`sqrt(n)` 以上の整数で割り切れる時は、
# `sqrt(n)` 以下の数でも割り切れているはずであるから、`sqrt(n)` 以上における比較は無駄である。

# したがってガウス記号を[]とすると `2..[sqrt(n)]` まででループを回し、
# 割り切れれば `false`
# 割り切れなければ `true`
# を返せばよいとわかる。

# 疑似コード

# prime?(n): nが素数かどうかを判定する関数
#     もし n <= 1 なら falseを返す
#     もし n == 2 なら trueを返す # 以下の繰り返しでは2は合成数だと判断されるため
#     繰り返し 2..[sqrt(n)] => i
#         もし n % i == 0なら(nがiで割り切れたら)
#             falseを返す
#         分岐終了
#     繰り返し終了
#     trueを返す

def prime?(n) # rubyなのでboolienを返す関数を象徴する?を付けた。
    if n <= 1 then return false end
    if n == 2 then return true end
    for i in 2..Math::sqrt(n).to_i
        if n % i == 0
            return false
        end
    end
    return true
end

for i in 1..100
    puts "#{i} is#{prime?(i) ? '' : ' not'} a prime number."
end

# =>
# 1 is not a prime number.
# 2 is a prime number.
# 3 is a prime number.
# 4 is not a prime number.
# 5 is a prime number.
# 6 is not a prime number.
# 7 is a prime number.
# 8 is not a prime number.
# 9 is not a prime number.
# 10 is not a prime number.
# 11 is a prime number.
# 12 is not a prime number.
# 13 is a prime number.
# 14 is not a prime number.
# 15 is not a prime number.
# 16 is not a prime number.
# 17 is a prime number.
# 18 is not a prime number.
# 19 is a prime number.
# 20 is not a prime number.
# ...
# 80 is not a prime number.
# 81 is not a prime number.
# 82 is not a prime number.
# 83 is a prime number.
# 84 is not a prime number.
# 85 is not a prime number.
# 86 is not a prime number.
# 87 is not a prime number.
# 88 is not a prime number.
# 89 is a prime number.
# 90 is not a prime number.
# 91 is not a prime number.
# 92 is not a prime number.
# 93 is not a prime number.
# 94 is not a prime number.
# 95 is not a prime number.
# 96 is not a prime number.
# 97 is a prime number.
# 98 is not a prime number.
# 99 is not a prime number.
# 100 is not a prime number.

# メソッドとして定義しなおしてみた

class Integer
    def prime?
        if self <= 1 then return false end
        if self == 2 then return true end
        for i in 2..Math::sqrt(self).to_i
            if self % i == 0
                return false
            end
        end
        return true
    end
end

for i in 1..100
    puts "#{i} is#{i.prime? ? '' : ' not'} a prime number."
end

# (結果は上記と変わらず)