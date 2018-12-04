# 基礎プログラミングおよび演習レポート #08

学籍番号: 1810156
\
氏名: ** ***
\
ペア学籍番号・氏名(または「個人作業」): 個人作業
\
提出日付: 2018/12/4

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L8/assignment8.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- 実行結果は`# =>`のコメントの後に記している場合があります。予めご了承ください。
- 実行結果等の一部を`~~ 省略 ~~`として省略している箇所があります。

- 時間の都合上、提出したレポートでは演習2までしか書けませんでした。実際は演習5までやっております(演習4eのみ時間が足りず行いませんでした)。もし演習3以降も評価していただけるならばありがたいです。m(_ _)m

## [課題の再掲]

### 演習 1

テキストにあるa ～ hのメソッドの時間計算量を見積もり、計測して選択があっていたかを確認する。

### 演習 2

同じ結果を返す計算量の異なるメソッドを作成し、答えが一致することを確認したのちに実行時間を比較する。

=> 今回はフィボナッチ数を求めるプログラムを複数作成した。

### 演習 3

モンテカルロ法で数値積分を行い円周率を求め、精度と試行数との関係について考察する

### 演習 4

いくつかのシミュレーションを行う

- a: サイコロを2個振った目の合計の分布を調べる。
- b: `60%`の確率で表が出るコインを10回投げ、表が出る回数の分布を調べる。
- c: サイコロを振ってうち2個が同じ目(もう一個は違う目)である確率がどれくらいか調べる。
- d: テキストに記載されているすごろくをシミュレートする

### 演習 5

乱数を使ったゲームを作成する。

=> 今回はじゃんけんゲームを作成した。

## [実施したこととその結果]

### 演習 1 時間計算量見積もり

以下のように計測用関数を用意した。

- `bench`: 時間を計測する。
- `tester`: 計測結果としてちょうどいい部分に関して、`n`を変えながら計測対象を実行し計測する。

```ruby
def bench(count = 1)
    start = Process.times.utime
    count.times do yield end
    end_t = Process.times.utime
    return end_t - start
end

def tester(f)
    for i in 1..10
        count = 10**i
        total_time = 0
        time_array = []
        for n in 10..1000
            time = bench(count) do method(f).call(n) end
            if time < 0.1 then break end # 短過ぎたら計測できないので抜け出し
            time_array << time
            total_time += time            
            if total_time > 10 then break end # 長すぎたら中断
        end
        time_array.each_with_index do |time, i|
            puts "#{f}: [count: #{count}, n: #{i+10}]: #{time}"
        end
        if total_time > 9 then break end
    end
end
```

#### a n^2

時間計算量は`O(1)`と判断した。

```ruby
def square1(n)
    return n*n
end

tester(:square1)
```

↓実行結果

```
square1: [count: 1000000, n: 10]: 0.6719999999999999
square1: [count: 1000000, n: 11]: 0.547
~~ 省略 ~~
square1: [count: 1000000, n: 25]: 0.625
square1: [count: 1000000, n: 26]: 0.657
```

このオーダーは妥当であると判断した。

#### b n^2

時間計算量は`O(n)`と判断した。

```ruby
def square2(n)
    result = 0
    n.times do result += n end
    return result
end

tester(:square2)
```

↓実行結果

```
square2: [count: 100000, n: 10]: 0.125
square2: [count: 100000, n: 11]: 0.14000000000000057
~~ 省略 ~~
square2: [count: 100000, n: 49]: 0.4529999999999994
square2: [count: 100000, n: 50]: 0.34399999999999764
```

このオーダーは妥当であると判断した。

#### c n^2

時間計算量は`O(n**2)`と判断した。

```ruby
def square3(n)
    result = 0
    n.times do
        n.times do
            result += 1
        end
    end
    return result
end

tester(:square3)
```

↓実行結果

```
square3: [count: 100000, n: 10]: 0.875
square3: [count: 100000, n: 11]: 0.8279999999999994
~~ 省略 ~~
square3: [count: 100000, n: 17]: 2.0
square3: [count: 100000, n: 18]: 2.0000000000000036
```

このオーダーは妥当であると判断した。

#### d 1.0000000001^n

時間計算量は`O(n)`と判断した。

```ruby
def near1pow1(n)
    result = 1.0
    n.times do result *= 1.0000000001 end
    return result
end

tester(:near1pow1)
```

↓実行結果

```
near1pow1: [count: 100000, n: 10]: 0.10999999999999943
near1pow1: [count: 100000, n: 11]: 0.125
~~ 省略 ~~
near1pow1: [count: 100000, n: 49]: 0.4059999999999988
near1pow1: [count: 100000, n: 50]: 0.4540000000000006
```

このオーダーは妥当であると判断した。

#### e 1.0000000001^n

時間計算量は`O(log n)`であると予想したが、計測では判別がはっきりしなかった。

```ruby
$call_count = 0

def near1pow2(n)
    $call_count += 1
    if n == 0
        return 1.0
    elsif n == 1
        return 1.0000000001
    elsif n % 2 > 0 # 基数
        return near1pow2(n-1) * 1.0000000001
    else # 偶数
        return near1pow2(n/2)**2
    end
end

tester(:near1pow2)
```

↓実行結果

```
near1pow2: [count: 100000, n: 10]: 0.14000000000000057
near1pow2: [count: 100000, n: 11]: 0.14099999999999824
~~ 省略 ~~
near1pow2: [count: 1000000, n: 17]: 1.1409999999999982
near1pow2: [count: 1000000, n: 18]: 1.296999999999997
```

別途以下のコードを実行してオーダーを推測した。

```ruby
for i in 1..100
    near1pow2(i)
    puts "#{$call_count} : log(#{i}) = #{Math.log(i, 2)}"
    # puts "#{$call_count} : sqrt(#{i}) = #{Math.sqrt(i)}"
    $call_count = 0
end
```

↓実行結果

```
1 : log(1) = 0.0
2 : log(2) = 1.0
3 : log(3) = 1.584962500721156
3 : log(4) = 2.0
~~ 省略 ~~
9 : log(97) = 6.599912842187128
9 : log(98) = 6.614709844115209
10 : log(99) = 6.6293566200796095
9 : log(100) = 6.643856189774725
```

`log n`が妥当であると判断できた。

#### f 1.0000000001^n

時間計算量は`O(1)`と判断した。

```ruby
def near1pow3(n)
    # 1.0000000001 ^ n = e ^ (ln( 1.0000000001 ^ n )) = e ^ (n * ln( 1.0000000001))
    return Math.exp(n*Math.log(1.0000000001))
end

tester(:near1pow3)
```

↓実行結果

```
near1pow3: [count: 1000000, n: 10]: 0.796999999999997
near1pow3: [count: 1000000, n: 11]: 0.6870000000000047
~~ 省略 ~~
near1pow3: [count: 1000000, n: 23]: 0.6099999999999994
near1pow3: [count: 1000000, n: 24]: 0.6089999999999947
```

このオーダーは妥当であると判断した。

#### g 1 ～ 3の値がn個並んだ全組み合わせを生成する

時間計算量は`O(3**n)`と判断した。

```ruby
def nest3n(n)
    nest3(n, "")
end

def nest3(n, s)
    if n <= 0
        # puts(s)
    else
        1.step(3) do |i| nest3(n-1, s+i.to_s) end
    end
end

tester(:nest3n)
```

↓実行結果

```
nest3n: [count: 10, n: 10]: 0.3440000000000083
nest3n: [count: 10, n: 11]: 0.9839999999999947
nest3n: [count: 10, n: 12]: 2.906000000000006
nest3n: [count: 10, n: 13]: 9.593999999999994
```

このオーダーは妥当であると判断した。

#### h 1 ～ nの値のすべての順列を生成する

時間計算量は`O(n!)`と判断した。

```ruby
def perm(n)
    a = Array.new(n) do |i| i+1 end
    perm_sub(a, [])
end

def perm_sub(a, b)
    if a.length == b.length
        # p b
    else
        a.each_index do |i|
            if a[i] != nil
                x = a[i]; a[i] = nil; b.push(x)
                perm_sub(a, b)
                a[i] = x; b.pop
            end
        end
    end
end

tester(:perm)
```

↓実行結果

```
perm: [count: 10, n: 10]: 125.57799999999999
```

上記に示すように`perm`に関しては`tester`ではよい計測が行えなかったので別途`bench`で計測した

```ruby
p(bench(1) do perm(8) end) # => 0.078
p(bench(1) do perm(9) end) # => 0.86
p(bench(1) do perm(10) end) # => 8.312000000000001
p(bench(1) do perm(11) end) # => 99.438
```

この実行結果よりオーダーは妥当であると判断した。

### 演習 2 フィボナッチ数を求める複数のプログラム

フィボナッチ数列に関して以下のコードを満たすように実装していった。

```ruby
def assert(flag)
    if !(flag) then raise "実装がおかしい！" end
end

def fib_checker
     assert yield(0)==0   
     assert yield(1)==1   
     assert yield(2)==1   
     assert yield(3)==2
     assert yield(4)==3
     assert yield(25)==75025
    #  assert yield(50)==12586269025
end
```

#### 再帰定義のフィボナッチ

以下は第4回でも実装した再帰によるフィボナッチ数を求める関数である。

```ruby
def fib_rec(n)
    if n <= 0
        return 0
    elsif n == 1
        return 1
    else
        return fib_rec(n-2) + fib_rec(n-1)
    end
end

p fib_rec(25) # => 75025
fib_checker do |n| fib_rec(n) end
```

#### 繰り返しを使用するフィボナッチ

前の値を記録することで再帰呼び出しよりも処理数を少なくした。
\
オーダーは`O(n)`ぐらいと考えられる。

```ruby
def fib_for(n)
    x0, x1 = 0, 1
    n.times do
        x0, x1 = x1, x0 + x1
    end
    return x0
end

p fib_for(50) # => 12586269025
fib_checker do |n| fib_for(n) end
```

#### 行列を使用するフィボナッチ(1)

さらにテキストにあった内容をもとに以下のように考え行列を使用するバージョンを作成した。

```
x[i+1] = x[i-1] + x[i]
x[i] = x[i]
```

より、行列

```
q = [[1, 1],
     [1, 0]]
```

を`[[x[i]], [x[i-1]]]`に掛けると、次の項を求めることができる。

`v = [[1], [1]]`とすると、行列の性質より、

```
fib_mat(n) = (q^n * v)[0][0]
```

であり、さらに

```疑似コード
if n == 0 then
    q^n == E
elsif n % 2 == 1 then
    q^n == q * q^(n-1)
elsif n % 2 == 0 then
    q^n == (q ^ (n/2)) ^ 2
end
```

より、処理回数を大幅に減らすことが可能である。

このことをもとにコードを実装した。
\
オーダーは`O(log n)`ぐらいであると考えられる。

```ruby
def dot(p, q)
    res = [[0, 0], [0, 0]]
    for i in 0..1
        for j in 0..1
            for k in 0..1
                res[i][j] = p[i][0] * q[0][j] + p[i][1] * q[1][j]
            end
        end
    end
    return res
end

def dot_exp(q, n)
    if n == 0
        return [[1, 0], [0, 1]]
    elsif n % 2 == 1
        return dot(q, dot_exp(q, n-1))
    elsif n % 2 == 0
        tmp = dot_exp(q, n/2)
        return dot(tmp, tmp)
    end
end

def fib_mat(n)
    q = [[1, 1], [1, 0]]
    if n == 0
        return 0
    else
        q_n = dot_exp(q, n)
        return q_n[1][0]
    end
end

p fib_mat(50) # => 12586269025
fib_checker do |n| fib_mat(n) end
```

#### 行列を使用するフィボナッチ(2) => 一般項の使用

行列は対角化ができることを利用し、処理を少なくすることを試みた。

`q = [[1, 1], [1, 0]]`

の固有値は

```
t = (1 + sqrt(5)) / 2
u = (1 - sqrt(5)) / 2
```

であるから、
`D = P^(-1) * q * P`
を満たす対角化行列`D`、正則行列`P`とその逆行列`P^(-1)`はそれぞれ

```
D = [[t, 0], [0, u]]
P = [[1, 1], [-u, -t]]
P^(-1) = (1/sqrt(5)) * [[t, 1], [-u, -1]]
```

ここで行列の性質より、

```
q^n = P * D^n * P^(-1)
D = [[t, 0], [0, u]]
-> D^n = [[t^n, 0], [0, u^n]]
```

この式を利用するとさらに処理が少なくなる。
\
オーダーは`O(n)`ぐらいであると考えられる。

一般項を使用しているということにほぼ等しいので、他の処理より速い。

```ruby
def fib_mat2(n)
    q = [[1, 1], [1, 0]]
    if n == 0
        return 0
    else
        t = (1 + Math::sqrt(5)) / 2
        u = (1 - Math::sqrt(5)) / 2
        q_n = dot(dot([[1, 1], [-u, -t]], [[t**n, 0], [0, u**n]]), [[t, 1], [-u, -1]])
        # return (q_n[1][0] / Math::sqrt(5)).to_i
        return q_n[1][0] / Math::sqrt(5)
    end
end

p fib_mat2(50) # => 12586269025
fib_checker do |n| fib_mat2(n).to_i end
```

#### 言語の機能: ジェネレータを使用する方法

`fib_for`をもとにジェネレータ版も作成した。
\
フィボナッチ「数列」を求める場合は、前の処理を続行できるので、ほかの処理より格段に速く実行できる。

```ruby
def fib_byGen(n)
    fib_gen = Enumerator.new do |y|
        x0, x1 = 0, 1
        loop do
            x0, x1 = x1, x0 + x1
            y << x0
        end
    end

    res = 0
    n.times do
        res = fib_gen.next
    end
    return res
end

p fib_byGen(50) # => 12586269025
fib_checker do |n| fib_byGen(n) end
```

#### 制限時間内にいくつまで処理できるかを比較した

```ruby
def fib_tester(func_name)
    start, lap = Process.times.utime, 0
    count, res = 0, 0
    func = method(func_name)
    while lap < 10 # 10秒以内にいくつまでたどり着けるかで競う
        res = func.call(count)
        count += 1
        lap = Process.times.utime - start
    end
    # puts "#{func_name}: #{count} = #{res}"
    puts "#{func_name}: #{count}"
end

fib_tester(:fib_rec)
fib_tester(:fib_for)
fib_tester(:fib_mat)
fib_tester(:fib_mat2)

$_fib_gen = Enumerator.new do |y|
    x0, x1 = 0, 1
    loop do
        x0, x1 = x1, x0 + x1
        y << x0
    end
end
def fib_gen(n)
    return $_fib_gen.next
end

fib_tester(:fib_gen)

# =>
# fib_rec: 38 = 24157817
# fib_for: 5540 = ~~ 省略 ~~
# fib_mat: 24352 = ~~ 省略 ~~
# prac2.rb:171:in `to_i': Infinity (FloatDomainError)
#         from prac2.rb:171:in `fib_mat2'
#         from prac2.rb:206:in `call'
#         from prac2.rb:206:in `fib_tester'
#         from prac2.rb:217:in `block in <main>'
#         from prac2.rb:213:in `times'
#         from prac2.rb:213:in `<main>'
```

となったためfib_mat2はコメントアウトの方で検証した
...PCが落ちた関係上フィボナッチ数の表示をやめることとした

```ruby
fib_rec: 38
fib_for: 5383
fib_mat: 24637
fib_mat2: 1403925
fib_gen: 938364
```

計算の容易さから、この計算方法の場合ジェネレータのほうが速いと踏んでいたが、そうではなかった模様...
\
途中でInfinityとなったことで計算が容易になったのではないかと推測し、3秒で数回競わせてみた

```ruby
def fib_tester2(func_name)
    start, lap = Process.times.utime, 0
    count, res = 0, 0
    func = method(func_name)
    while lap < 3 # 10秒以内にいくつまでたどり着けるかで競う
        res = func.call(count)
        count += 1
        lap = Process.times.utime - start
    end
    # puts "#{func_name}: #{count} = #{res}"
    puts "#{func_name}: #{count}"
end

fib_tester2(:fib_mat2)

$_fib_gen = Enumerator.new do |y|
    x0, x1 = 0, 1
    loop do
        x0, x1 = x1, x0 + x1
        y << x0
    end
end
def fib_gen(n)
    return $_fib_gen.next
end

fib_tester2(:fib_gen)

# 1回目
# fib_mat2: 433838
# fib_gen: 462170

# 2回目
# fib_mat2: 442295
# fib_gen: 460053

# 3回目
# fib_mat2: 406926
# fib_gen: 472060
```

フィボナッチ数列を求める場合はジェネレータのほうがいい結果となった。

##### 勝負の方法を変えて、第40000項目を求めるのにかかる時間で比較した。

```ruby
def fib_tester3(func_name)
    start = Process.times.utime
    method(func_name).call(40000)
    end_t = Process.times.utime
    puts "#{func_name}: #{end_t - start}s"
end

fib_tester3(:fib_mat2)
fib_tester3(:fib_byGen)

# 1回目
# fib_mat2: 0.0s
# fib_byGen: 0.094s

# 2回目
# fib_mat2: 0.0s
# fib_byGen: 0.07800000000000001s

# 3回目
# fib_mat2: 0.0s
# fib_byGen: 0.07800000000000001s
```

この場合は`fib_mat2`のほうが速かった。

### 演習 3 モンテカルロ法

以下のようにモンテカルロ法を用いた数値積分で円周率を求めるプログラムを作成し、試行回数を変えて検証してみた。

```ruby
def pi_random(n)
    count = 0
    n.times do
        x, y = rand(), rand()
        if x ** 2 + y**2 < 1.0 then count += 1 end
    end
    return 4.0 * count / n.to_f
end

for i in 1..9
    t = 10**i
    puts "#{t} => #{pi_random(t)}"
end

# =>
# 10 => 3.2
# 100 => 3.08
# 1000 => 3.172
# 10000 => 3.1116
# 100000 => 3.14676
# 1000000 => 3.14554
# 10000000 => 3.1416292
# 100000000 => 3.14158736
# 1000000000 => 3.141595348

# =>
# 10 => 2.8
# 100 => 3.28
# 1000 => 3.176
# 10000 => 3.1208
# 100000 => 3.1516
# 1000000 => 3.140108
# 10000000 => 3.1415628
# 100000000 => 3.14151236
# 1000000000 => 3.141635568
```

試行回数に比例して有効数字は増えているものの、必ずしも精度が上がるとは限らないということが確認できる。
\
すなわちどこまでが正確な値であるかを判断するのが難しいので実用性に欠ける、といえる。

### 演習 4 シミュレーション

#### a 二つのサイコロのシミュレーション

以下のようにサイコロのシミュレーションを行った。
\
2個振った目の合計の分布を調べた。

```ruby
def two_dice_sim(n = 10000)
    dist_arr = Array.new(13, 0)
    n.times do
        dice_a = rand(1..6)
        dice_b = rand(1..6)
        dist_arr[dice_a + dice_b] += 1
    end
    res = {}
    for i in 2..12
        res[i] = "#{(dist_arr[i] / n.to_f) * 100}%"
    end
    return res
end

p two_dice_sim

# =>
# {2=>"2.88%", 3=>"4.97%", 4=>"8.68%", 5=>"10.97%", 6=>"13.669999999999998%", 7=>"16.5%", 8=>"14.6%", 9=>"11.469999999999999%", 10=>"8.32%", 11=>"5.4%", 12=>"2.54%"}
# {2=>"2.92%", 3=>"5.52%", 4=>"8.459999999999999%", 5=>"10.82%", 6=>"13.889999999999999%", 7=>"16.34%", 8=>"13.41%", 9=>"11.91%", 10=>"8.61%", 11=>"5.46%", 12=>"2.6599999999999997%"}
# {2=>"2.82%", 3=>"5.67%", 4=>"8.27%", 5=>"11.18%", 6=>"13.91%", 7=>"16.7%", 8=>"14.04%", 9=>"10.57%", 10=>"8.51%", 11=>"5.53%", 12=>"2.8000000000000003%"}
```

7で最も確率が高くなっているのが確認できる。

↓ 実際の確率を求める(数学はやりたくないのでこれもプログラム)

```ruby
def two_dice_dist
    dist_arr = Array.new(13, 0)
    for i in 1..6
        for j in 1..6
            dist_arr[i + j] += 1
        end
    end
    res = {}
    for i in 2..12
        res[i] = ("%.3f" % ((dist_arr[i] / 36.0) * 100) ) + "%"
    end
    return res
end

p two_dice_dist

# =>
# {2=>"2.778%", 3=>"5.556%", 4=>"8.333%", 5=>"11.111%", 6=>"13.889%", 7=>"16.667%", 8=>"13.889%", 9=>"11.111%", 10=>"8.333%", 11=>"5.556%", 12=>"2.778%"}
```

シミュレーションは大体うまくいっていることが確認できる。

#### b コインのシミュレーション

以下のように`60%`の確率で表が出るコインのシミュレーションを行った。
\
10回投げて表が出た回数の分布を調べた。

```ruby
def ikasama_coin_sim(n = 10000)
    dist_arr = Array.new(11, 0)
    n.times do
        win = 0
        10.times do
            win += rand(1..100) < 60 ? 1 : 0
        end
        dist_arr[win] += 1
    end
    res = {}
    dist_arr.each_with_index do |w, i|
        res[i] = ("%.3f" % ((w / n.to_f) * 100) ) + "%"
    end
    return res
end

p ikasama_coin_sim

# =>
# {0=>"0.010%", 1=>"0.180%", 2=>"1.390%", 3=>"4.710%", 4=>"11.980%", 5=>"21.290%", 6=>"24.850%", 7=>"20.480%", 8=>"11.020%", 9=>"3.440%", 10=>"0.650%"}
# {0=>"0.020%", 1=>"0.150%", 2=>"1.320%", 3=>"4.760%", 4=>"12.380%", 5=>"21.170%", 6=>"24.480%", 7=>"20.890%", 8=>"10.600%", 9=>"3.630%", 10=>"0.600%"}
# {0=>"0.020%", 1=>"0.160%", 2=>"1.430%", 3=>"5.150%", 4=>"12.000%", 5=>"21.340%", 6=>"24.720%", 7=>"19.610%", 8=>"11.660%", 9=>"3.510%", 10=>"0.400%"}
```

↓ 実際の確率を求める(例によって数学はやりたくないのでプログラムで)

```ruby
def comb(n, r) # 第4回演習4で作成したプログラムを借用
	return (r == 0 or r == n) ? 1 : comb(n-1, r) + comb(n-1, r-1)
end

def ikasama_coin_dist
    dist_arr = Array.new(11, 0)

    11.times do |i|
        dist_arr[i] = comb(10, i) * 0.6**i * 0.4**(10-i)
    end

    res = {}
    dist_arr.each_with_index do |w, i|
        res[i+1] = ("%.3f" % (w * 100) ) + "%"
    end
    return res
end

p ikasama_coin_dist

# =>
# {1=>"0.010%", 2=>"0.157%", 3=>"1.062%", 4=>"4.247%", 5=>"11.148%", 6=>"20.066%", 7=>"25.082%", 8=>"21.499%", 9=>"12.093%", 10=>"4.031%", 11=>"0.605%"}
```

シミュレーションは大体うまくいっていることが確認できる。

#### c 3つのサイコロのシミュレーション

以下のようにサイコロのシミュレーションを行った。
\
3つのサイコロのうち2つだけがぞろ目になる確率をシミュレートした。

```ruby
def three_dice_sim(n = 10000)
    win = 0
    n.times do
        dice_a = rand(1..6)
        dice_b = rand(1..6)
        dice_c = rand(1..6)
        cond1 = not(dice_a == dice_b and dice_b == dice_c and dice_c == dice_a)
        cond2 = (dice_a == dice_b or dice_b == dice_c or dice_c == dice_a)
        if cond1 and cond2
            win += 1
        end
    end
    return win / n.to_f
end

p three_dice_sim

# =>
# 0.4127
# 0.4232
# 0.4194
```

↓ 実際の確率を求める(例によって数学はやりたくないのでプログラムで)

```ruby
def three_dice_dist(n = 10000)
    win = 0
    for i in 1..6
        for j in 1..6
            for k in 1..6
                cond1 = not(i == j and j == k and k == i)
                cond2 = (i == j or j == k or k == i)
                if cond1 and cond2
                    win += 1
                end
            end
        end
    end
    return win / 216.0
end

p three_dice_dist

# =>
# 0.4166666666666667
```

シミュレーションは大体うまくいっていることが確認できる。

#### d すごろくのシミュレーション

以下のようにすごろくのシミュレーションを行った。
\
すごろくの内容はテキストにあるものである。

```ruby
# すごろくで起きるイベント

$events = [
    lambda {|pos| pos}, # スタート
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos + 5}, # 5進む <- 8に行くと同義であるが忠実に再現
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| 17}, # ワープ
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos - 10},
    lambda {|pos| pos},
    lambda {|pos| pos + 3},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| 0},
    lambda {|pos| pos}
]

def sugoroku_sim(n = 10000)
    dist_dic = {}
    n.times do
        count = 0
        pos = 0
        while pos < 19
            count += 1
            dice = rand(1..6)
            pos += dice
            if pos < 20 then pos = $events[pos].call(pos) end
        end
        if dist_dic[count] != nil
            dist_dic[count] += 1
        else
            dist_dic[count] = 1
        end
    end
    return dist_dic.inject({}) do |a, (k, v)| a[k] = ("%.3f" % (v / n.to_f * 100) ) + "%" ;a end
end

res = sugoroku_sim
for k, v in res
    puts "#{k}: #{v}"
end

# =>
# 5: 17.690%
# 7: 7.890%
# 11: 3.330%
# 4: 18.270%
# 6: 11.950%
# 3: 14.340%
# 15: 1.030%
# 10: 4.160%
# 17: 0.780%
# 8: 5.930%
# 9: 5.280%
# 16: 0.850%
# 14: 1.500%
# 20: 0.360%
# 13: 1.860%
# 28: 0.050%
# 12: 2.440%
# 23: 0.130%
# 21: 0.350%
# 19: 0.510%
# 24: 0.110%
# 25: 0.140%
# 33: 0.020%
# 26: 0.100%
# 22: 0.260%
# 18: 0.470%
# 38: 0.010%
# 31: 0.050%
# 30: 0.040%
# 27: 0.050%
# 36: 0.010%
# 29: 0.010%
# 35: 0.020%
# 47: 0.010%
```

5 ～ 4回ぐらいであがれるということがわかった。

さすがにこれに関しては数学的検証は省略する。

### 演習 5 乱数を使ったゲームの作成

じゃんけんゲームを作成した。(英語でrock-paper-scissors)

```ruby
$hand_kind = {r: "ぐー", p: "ぱー", s: "ちょき"}

$judge_kind = ["まけ", "あいこ", "かち"]

$judge_man = { # $judge_man[hand][cpu]
    r: {r: 1, p: 0, s: 2},
    p: {r: 2, p: 1, s: 0},
    s: {r: 0, p: 2, s: 1}
}

def rps_game(hand)
    cpu = [:r, :p, :s].sample
    judge = $judge_man[hand][cpu]
    return cpu, judge
end

def rps_game_main
    puts "じゃんけんげ～む！！"
    print("ぐー0, ちょき:1, ぱー:2 : ")
    hand = readline
    hand = [:r, :s, :p][hand.sub(/\n/, "").to_i]
    cpu, judge = rps_game(hand)
    puts "あなた: #{$hand_kind[hand]}\nあいて: #{$hand_kind[cpu]}\nはんてい: #{$judge_kind[judge]}"
end

rps_game_main

# =>
# $ ruby prac5.rb
# じゃんけんげ～む！！
# ぐー:0, ちょき:1, ぱー:2 : 0
# あなた: ぐー
# あいて: ぱー
# はんてい: まけ

# $ ruby prac5.rb
# じゃんけんげ～む！！
# ぐー:0, ちょき:1, ぱー:2 : 1
# あなた: ちょき
# あいて: ちょき
# はんてい: あいこ

# $ ruby prac5.rb
# じゃんけんげ～む！！
# ぐー:0, ちょき:1, ぱー:2 : 2
# あなた: ぱー
# あいて: ぐー
# はんてい: かち
```

乱数部分に関して、配列から1つ要素をランダムに取り出してくれる便利なメソッド`sample`を使用した。
\
ハッシュなどを使用することですっきり書くことができた。

## [考察]

演習2について、実験して示したように類似した処理でも何をしたいかによって有利な実装は変わってくるので、
\
「絶対にこれが一番速い」というコードといえるかどうかに関しては慎重に判断する必要があることがわかった。

乱数シミュレーションに関しては、演習4dのように計算が難しいものに関してはとても有効であるということがわかった。
\
使いどころを見極めていきたい。

## [アンケート]

- Q1. 乱数を使ったアルゴリズムを自分なりにどのように考えますか。

人工知能の研究などでも顔を出す部分なので非常に重要であると考えております。

- Q2. シミュレーションを構成するときのコツは何だと思いますか。

全てのパターンを予め想定または予想することでしょうか?
\
テストを書くことは必要だったかなと振り返って思います。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

今回は中間テストと被り余裕をもって取り組めなかったので、次回はしっかりと取り組みたいです。
\
次回も頑張Ruby!