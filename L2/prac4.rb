# a 非負整数 `n` を受け取り、`2^n` を計算する。

def two_exp(n)
    ans = 1
    n.times do
        ans *= 2
    end
    return ans
end

puts two_exp(2) # => 4
puts two_exp(4) # => 16
puts two_exp(8) # => 256
puts two_exp(10) # => 1024
puts two_exp(20) # => 1048576

# b 非負整数nを受け取り、`n! = n * (n - 1) * ... * 2 * 1` を計算する。

def fact(n)
    ans = 1
    for i in 1..n
        ans *= i
    end
    return ans
end

puts fact(3) # => 6
puts fact(5) # => 120
puts fact(15) # => 1307674368000
puts fact(20) # => 2432902008176640000

## おまけ: 階乗は再帰呼び出しをつかったほうが直感的に書ける関数である。

def fact(n)
    if n <= 1
        return 1
    else
        return n * fact(n - 1)
    end
end

puts fact(3) # => 6
puts fact(5) # => 120
puts fact(15) # => 1307674368000
puts fact(20) # => 2432902008176640000

# 結果は変わらない。

# c コンビネーション `nCr` の実装

# 分子に関しては
# パフォーマンスを考慮すると下手に再帰呼び出しを行ったりはせず、
# for文だけで書くほうが良いと考えられるのでそのように実装する。

def combination(n, r)
    num = 1 # Numerator 分子
    for i in (n-r+1)..n
        num *= i
    end
    den = fact(r) # Denominator 分母
    return num / den
end

puts combination(5, 3) # => 10
puts combination(10, 2) # => 45
puts combination(7, 4) # => 35

# テイラー展開によるsin関数とcos関数の実装

pi = Math::PI

def sin(x, n=5)
    s = 0
    for i in 1..n
        j = 2*i - 1
        if i % 2 == 0
            s += -x**j / fact(j).to_f 
        else
            s += x**j / fact(j).to_f
        end
    end
    return s
end

puts sin(0) # => 0.0
puts sin(pi / 6.to_f) # => 0.5000000000202799
puts sin(pi / 4.to_f) # => 0.7071067829368671
puts sin(pi / 3.to_f) # => 0.8660254450997811
puts sin(pi / 2.to_f) # => 1.0000035425842861
puts sin(2*pi / 3.to_f) # => 0.8661082667623468
puts sin(3*pi / 4.to_f) # => 0.7074072812445046
puts sin(5*pi / 6.to_f) # => 0.5009497762766237
puts sin(pi) # => 0.006925270707505135
puts sin(7*pi / 6.to_f) # => -0.4630779032063598
puts sin(5*pi / 4.to_f) # => -0.6291965775262263
puts sin(4*pi / 3.to_f) # => -0.7096043731826163
puts sin(3*pi / 2.to_f) # => -0.444365928237735
puts sin(5*pi / 3.to_f) # => 0.8507699599446568
puts sin(7*pi / 4.to_f) # => 2.1813355319161545
puts sin(11*pi / 6.to_f) # => 4.236803507932539

def cos(x, n=5)
    s = 0
    for i in 0..n-1
        j = 2*i
        if i % 2 == 0
            s += x**j / fact(j).to_f
        else
            s += -x**j / fact(j).to_f
        end
    end
    return s
end

puts cos(0) # => 1.0
puts cos(pi / 6.to_f) # => 0.8660254042103523
puts cos(pi / 4.to_f) # => 0.7071068056832942
puts cos(pi / 3.to_f) # => 0.500000433432915
puts cos(pi / 2.to_f) # => 2.473727636469452e-05
puts cos(2*pi / 3.to_f) # => -0.49956698894078944
puts cos(3*pi / 4.to_f) # => -0.7057128042241849
puts cos(5*pi / 6.to_f) # => -0.8620659390685108
puts cos(pi) # => -0.9760222126236076
puts cos(7*pi / 6.to_f) # => -0.7568776205769262
puts cos(5*pi / 4.to_f) # => -0.4926066564757843
puts cos(4*pi / 3.to_f) # => -0.09717676171775791
puts cos(3*pi / 2.to_f) # => 1.2657143754965308
puts cos(5*pi / 3.to_f) # => 4.001102257077905
puts cos(7*pi / 4.to_f) # => 6.301425190013209
puts cos(11*pi / 6.to_f) # => 9.598041291484872

# n = 5の場合は
# sin関数、cos関数共に0 <= theta <= pi/2 の範囲ではほぼ正確な値を返していたが、遠くになるにつれ
# 精度が悪くなっていることが観測できる。

puts sin(10 * pi) # => 76403121.4250545
puts sin(-10 * pi) # => -76403121.4250545
puts cos(10 * pi) # => 22237894.90807884

# やはり5項程度ではものすごく精度が悪い(どころの差ではない)

puts sin(10 * pi, 100) # => 0.0006695609195825486
puts sin(-10 * pi, 100) # => -0.0006695609195825486
puts cos(10 * pi, 100) # => 0.9994368755241171

# 60項以上増やしても100項までほとんど変化がなかったので、60程は要らないと考えられる。
# しかしどの程度の項が必要かは引数によって決まることより、
# 項目数を多くするより引数を2*piで引いていき小さくするほうが現実的である。

def sin(x, n=5)
    while x < 0 do x += 2*Math::PI end
    while x >= 2*Math::PI do x -= 2*Math::PI end
    s = 0
    for i in 1..n
        j = 2*i - 1
        if i % 2 == 0
            s += -x**j / fact(j).to_f 
        else
            s += x**j / fact(j).to_f
        end
    end
    return s
end

puts sin(10 * pi) # => 0.0
puts sin(-10 * pi) # => 0.0