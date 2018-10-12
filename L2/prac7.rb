# エラトステネスの篩を利用した素数算出

# エラトステネスの篩の原理

# 予め2..nまでの値を配列に格納しておき、
# 2から順に素数の倍数となっている数を落としていくというアルゴリズムである。
# 例えば2で回すときは
# 4、6、8、10、12、14、16...
# は素数ではないので配列から外していく。
# 2が終わったのちの、配列中に残る2より大きいもっとも小さい数は3であり、
# この時点で3は1と自身以外に約数を持たないので素数だとわかる。
# そして素数である3について2と同様の操作をしていく。
#
# n以下の数で素数ではない数はsqrt(n)以下の数を必ず約数に持つことから、
# この比較はsqrt(n)まででよい。

# 疑似コード

# primes_byErat(n): nまでの数のうち素数を返すプログラム
#     素数リスト <= 2からnまでの配列
#     2からsqrt(n) まで繰り返し => 繰り返し変数i
#         j に i * 2 を代入 # i は素数であるため
#         j が n より小さいうちは繰り返し
#             もし 素数リスト内にjがあったら 素数リストから j を除く # 配列に備わるメソッドdeleteを使用
#             j に i を足して代入する
#         繰り返し終了
#     繰り返し終了
#     素数リストを返す

def primes_byErat(n)
    lis = Array(2..n)
    for i in 2..Math::sqrt(n).to_i
        j = i * 2
        while j <= n
            lis.delete(j)
            j += i
        end
    end
    return lis
end

primes = primes_byErat(1000)

# puts primes

require "./prac6" # 演習 6の関数で結果が正しいかを判断する

def checker(lis)
    for i in lis
        if ! i.prime?
            puts "False!!!"
            return
        end
    end
    puts "OK!"
end

# checker(primes) # => OK!

# 以下、10秒間にいくつ処理できるかをテストする。
i = 1000

while true
    t = Time.now
    primes = primes_byErat(i)
    dt = Time.now - t
    if dt >= 10
        puts "Time : #{dt} s"
        puts "i : #{i}"
        puts "len : #{primes.length}"
        break
    end
    i += 100
end

# =>
# Time : 10.086062 s
# i : 13500
# len : 1600

# だいたい10秒で13500個ほどは処理できることが分かった。
# 以下細かく調査する。

i = 13500

while true
    t = Time.now
    primes = primes_byErat(i)
    dt = Time.now - t
    if dt <= 10
        puts "Time : #{dt} s"
        puts "i : #{i}"
        puts "len : #{primes.length}"
        break
    end
    i -= 1
end

# =>
# Time : 9.792734 s
# i : 13500
# len : 1600

# 状況が違ったからか、13500から減らす方向で実行した場合は13500でも10秒を切った。
# とりあえずこれらの結果より`13500`が10秒以内で実行できる`n`として妥当と判断した。