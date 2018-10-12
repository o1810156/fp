# 基礎プログラミングおよび演習レポート ＃02

学籍番号: 1810156
\
氏名: ** ***
\
ペア学籍番号・氏名(または「個人作業」): 「個人作業」
\
提出日付: 2018/10/13

## レポートに関する注意点等(お願い)

- 前回レポートに引き続きマークダウン記法を多用しています。
- 前回レポートでは用意できませんでしたが、見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L2/assignment2.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- 実行結果は`# =>`のコメントの後に記しています。予めご了承ください。

## [課題の再掲]

### 演習 2

- a: 2つの異なる実数`a`、`b`を受け取り、より大きいほうを返す。 (activity report にて提出したので飛ばす)
- b: 3つの異なる実数`a`、`b`、`c`を受け取り、最大のものを返す。
- c: 実数を 1 つ受け取り、それが正なら`"positive"`、負なら`"negative"`、零なら`"zero"`という文字列を返す。

### 演習 3

演習 3はレポート範囲外であるが、よく取り組んだので一応レポートに含めることにした。(一方演習 1の内容は前回レポートと被るという理由もあり載せない。)

- テキストにある数値積分の式を実装、実行したのちに特徴を観察し、以下の方法で改善を試みる。
    - a: 左端の`x`だけでも右端の`x`だけでも弱点があるので、両方で計算して平均を取る。
    - b: 左端や右端だからよくないので、区間の中央の`x`を使う。
    - c: 上記`a`と`b`をうまく組み合わせてみる。

### 演習 4

繰り返しを使った以下のようなプログラムを作成する。

- a: 非負整数`n`を受け取り、`2^n`を計算する。
- b: 非負整数`n`を受け取り、`n! = n × (n − 1) × ... × 2 × 1`を計算する。
- c: 非負整数`n`と`r(≤ n)`を受け取り、`nCr`を計算する。
- d: `x`と計算する項の数`n`を与えて、`sin`、`cos`関数のテイラー展開を計算する。

### 演習 5

2つの正の整数`x`、`y`に対してその最大公約数を求めるアルゴリズムの疑似コードを書き、Rubyプログラムを作成する。
\
また、この方法の原理を説明する。

### 演習 6

「正の整数`N`を受け取り、`N`が素数なら`true`、そうでなければ`false`を返すRubyプログラム」を書く。まず疑似コードを書き、次にRubyに直す。

### 演習 7

「正の整数`N`を受け取り、`N`以下の素数をすべて打ち出すRubyプログラム」を書く。待ち時間`10`秒以内でいくつの`N`まで処理できるか調べて報告する。

## [実施したこととその結果・考察]

注意点: 前回レポートでは例外処理を一部含めたが、今回はアルゴリズムに主眼を置いているため、**例外を全く考慮していないコードが複数ある**。

### 演習 2 大小比較

#### b 3つの異なる実数`a`、`b`、`c`を受け取り、最大のものを返す。

とりあえず普通に実装した。

```疑似コード
max: 変数a、b、cのうち最大のものをかえす
    mにaを代入
    b > mならmは最大値ではないのでこちらをmに代入
    c > mならmは最大値ではないのでこちらをmに代入
    aを返す
```

```ruby
def max(a, b, c)
	m = a
	if b > m then m = b end
	if c > m then m = c end
	return m
end

puts "max(1, 2, 3) = #{max(1, 2, 3)}" # => max(1, 2, 3) = 3
puts "max(2, 3, 1) = #{max(2, 3, 1)}" # => max(2, 3, 1) = 3
puts "max(3, 2, 1) = #{max(3, 2, 1)}" # => max(3, 2, 1) = 3
```

これだと3つまでしか受け取れないので、配列を受け取れるように改良した。
\
配列を`for`文で回し各繰り返しで`i > mならmは最大値ではないのでこちらをmに代入`というコードを実行している。

```ruby
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
puts "max(1, 2, 3) = #{max(1, 2, 3)}" # 上書きしたためにエラーになる
# =>
# prac2.rb:28:in `max': wrong number of arguments (3 for 1) (ArgumentError)
#	from prac2.rb:39:in `<main>'
```

配列だと記述が面倒であるため可変長変数版も実装してみた。

```ruby
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
```

配列も受け取れるようにさらに改良した。

```ruby
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
```

全て正しい結果であることが確かめられる。

#### c 実数値の正負の分類

こちらも特に難しい点はなく、予め組んだ疑似コードをRubyにしただけである。

```疑似コード
judge: 変数xが正か負か0かを判断する
    もしxが0より大きければ
        "positive"を返す
    そうでなく0より小さければ
        "negative"を返す
    分岐終了
    "zero"を返す
```

```ruby
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
```

整数実数共に想定通りの挙動をしている。
\
今回のコードに関し、関数の`return`の性質を利用し分岐を簡単にした。比較回数が減るメリットがある。

### 演習 3 数値積分の式を実装、実行したのちに特徴を観察し、改善を試みる。

まずはテキストに載っていたコードをそのまま書き実行した。

```ruby
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
```

本来の答えは`333`であるが、whileで実装したために余分な繰り返しが起こり余計な体積が足されている。
\
これを踏まえ`times`メソッドで実装しなおした。また情報落ちによる誤差を防ぐため`a`に`i*dx`を足す形で`x`を決めた。

```ruby
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
```

`n = 10000`ではある程度の改善が見られた。
\
次に様々な関数に対応できるよう書き直した。

```ruby
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
```

このように円周率を求めることも可能である。ただし精度はそこまで高くない。
\
この方法で実装した際、`n`を大きくしていくと減少関数ではどのように値が収束するかを見る。

```ruby
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
```

正しい答え`666.6666666....`に大きいほうから近づいていることが観測できる。
\
これは減少関数では右端が実際の値より大きくなっているためである。
\
次に右端で計算させた。

```ruby
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
```

増加関数では値が大きいほうから近づき、

```ruby
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
```

減少関数では値が小さいほうから近づくのが確認できる。

```ruby
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
```

#### a 左端の`x`だけでも右端の`x`だけでも弱点があるので、両方で計算して平均を取る。

`y(左端x)`と`y(右端x)`の平均を区間の高さとして計算させた。

```ruby
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
```

精度の向上はよく見られた。
\
挙動は今回は右端で計算した場合と等しく
\
作図して考えることで
\
上に凸だと実際の値より小さく、
\
下に凸だと実際の値より大きいことがわかる。

#### b 左端や右端だからよくないので、区間の中央の`x`を使う。

両端の`x`を使うのではなく、`右端x`と`左端x`の中央にある`x`をつかって計算させた。

```ruby
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
```

平均のときと同じく
\
精度の向上はよく見られた。
\
挙動は今回は左端で計算した場合と等しく
\
作図して考えることで
\
上に凸だと実際の値より大きく、
\
下に凸だと実際の値より小さいことがわかる。

#### c 上記`a`と`b`をうまく組み合わせてみる。

シンプソン公式というものがあるらしく、
\
`(右端 + 中央値*4 + 左端) / 6`の値を使うといいらしいので実装してみた

```ruby
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
```

ものすごい良い精度で近似ができた。
\
実行結果を見る限り分割数を上げすぎないほうが精度がよいという不思議な点が見られた。
\
2次曲線で近似しているために、精度によっては完全に一致する時があるからかと考えられる。

```ruby
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
```

このように2次曲線ではない関数だとやはり精度を上げたほうが正確であることがわかる。

### 演習 4 繰り返しを使用したプログラムの作成

#### a 非負整数`n`を受け取り、`2^n`を計算する。

`**`を使用すればよいがそれでは繰り返しにならないので`times`メソッドを使って実装した。

```ruby
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
```

#### b 非負整数nを受け取り、`n! = n * (n - 1) * ... * 2 * 1` を計算する。

繰り返し変数(コード中では`i`)を結果を保持する変数(コード中では`ans`)に掛けていくだけである。
\
関数名`fact`は"factorial"(階乗)の略である。

```ruby
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
```

##### おまけ

階乗は再帰呼び出しをつかったほうが直感的に書ける関数である。
\
以下仕組みを疑似コード中にコメントして説明する。

```疑似コード
fact: 引数nの階乗を返す
    もし nが1以下ならば
    # 負数に関しては今回は考えない。また0! = 1より整合性は取れている。
        1を返す
    そうでなければ
        # fact(n)が仮に定義されているならば、n! = n * (n - 1)! であるから正しい値が返る
        n * fact(n - 1)を返す
    分岐終了
```

したがって`if`文だけで次のように書ける。

```ruby
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
```

結果は変わらない。

#### c コンビネーション `nCr` の実装

分子に関しては
\
パフォーマンスを考慮すると下手に`fact`を呼んだりはせず、
\
`for`文だけで書くほうが良いと考えられるのでそのように実装する。
\
数式に従って定義するだけなので疑似コードは略した。

```ruby
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
```

#### d テイラー展開によるsin関数とcos関数の実装

偶数項と奇数項で符号が異なるので、if文を使って分岐させた。
\
数学と同様に`(-1)**n`を使用する手もあるが、実際は1オーダーで済む剰余演算に対して`(-1)**n`は呼び出し回数が多くなりパフォーマンス低下の原因となると考え、こちらは避け`if`文で実装した。
\
分岐内の処理は数式に合わせただけである。

```ruby
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
```

`n = 5`の場合は
\
`sin`関数、`cos`関数共に`0 <= theta <= pi/2`の範囲ではほぼ正確な値を返していたが、遠くになるにつれ
\
精度が悪くなっていることが観測できる。

```ruby
puts sin(10 * pi) # => 76403121.4250545
puts sin(-10 * pi) # => -76403121.4250545
puts cos(10 * pi) # => 22237894.90807884
```

やはり5項程度ではものすごく精度が悪い(どころの差ではない)

```ruby
puts sin(10 * pi, 100) # => 0.0006695609195825486
puts sin(-10 * pi, 100) # => -0.0006695609195825486
puts cos(10 * pi, 100) # => 0.9994368755241171
```

60項以上増やしても100項までほとんど変化がなかったので、60程は要らないと考えられる。
\
しかしどの程度の項が必要かは引数によって決まることより、
\
項目数を多くするより引数から`2*pi`を引いていき小さくするほうが現実的である。

```ruby
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
```

### 演習 5 最大公約数を求めるアルゴリズムの実装

以下、原理を説明し疑似コードを載せた上でRubyで実装した。

#### 原理

`x`と`y`の最大公約数を`g`とすると、

`x = ag`
\
`y = bg`

と表せられる。ここで

##### `x = y`のとき 原理(1)

`a = b`で、`g`は最大公約数である必要があるため、
\
`a = b = 1`
\
ゆえに `x = y = g`

##### `x > y`のとき(`y > x`も同様) 原理(2)

`x - y = (a - b)g`
\
ここで`x - y`は整数でありまた右辺より最大公約数`g`の倍数である。
\
したがって、`x - y`と`y`の最大公約数もまた`g`となる。
    
よって最大公約数を返す関数`gcd(x, y)`に関し
\
`gcd(x, y) = g(x - y, y)`

#### 疑似コード

```疑似コード
gcd(x, y): xとyの最大公約数を返す
    もしx = yのとき
        最大公約数は x # 原理(1)より
    ではなくてx > yのとき
        最大公約数は gcd(x - y, y) # 原理(2)より
    そうではない(このときx < y)
        最大公約数は gcd(x, y - x) # 原理(2)より
    分岐終了
```

#### プログラムとその原理

数学的な考えをもとに再帰処理的に呼び出しているだけである。
\
したがって上記原理による部分がすべてである。

```ruby
def gcd(x, y)
    if x == y
        return x
    elsif x > y
        return gcd(x - y, y)
    else
        return gcd(x, y - x)
    end
end

puts gcd(27, 36) # => 9
puts gcd(24, 36) # => 12
puts gcd(3, 7) # => 1 # 互いに素の場合も求められる
```

想定通りの挙動となった。

### 演習 6 素数判定プログラム(1)

以下、原理を説明し疑似コードを載せた上でRubyで実装した。

#### 原理

nが素数であるということは `2..n-1` までの整数でnは割り切れないということである。
であるから `2..n-1` でループを回せばよいが、`sqrt(n)` 以上の整数で割り切れる時は、
`sqrt(n)` 以下の数でも割り切れているはずであるから、`sqrt(n)` 以上における比較は無駄である。

したがってガウス記号を`[]`とすると `2..[sqrt(n)]` まででループを回し、
割り切れれば `false`
割り切れなければ `true`
を返せばよいとわかる。

#### 疑似コード

```
prime?(n): nが素数かどうかを判定する関数
    もし n <= 1 なら falseを返す
    もし n == 2 なら trueを返す # 以下の繰り返しでは2は合成数だと判断されるため
    繰り返し 2..[sqrt(n)] => i
        もし n % i == 0なら(nがiで割り切れたら)
            falseを返す
        分岐終了
    繰り返し終了
    trueを返す
```

#### プログラムとその原理

ほぼ疑似コードのままである。無駄な繰り返しを避けるには`return`または`break`を使うとよく、今回は利便性が高い`return`を使用した。
\
またガウス記号の代わりに`to_i`メソッドを使用している。

```ruby
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
```

`Integer`クラスのメソッドとして定義しなおしてみた

```ruby
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
```

(結果は上記と変わらず)

### 演習 7 素数判定プログラム(2) エラトステネスの篩を利用した素数算出

以下、原理を説明し疑似コードを載せた上でRubyで実装した。

#### エラトステネスの篩の原理

予め`2..n`までの値を配列に格納しておき、
\
`2`から順に素数の倍数となっている数を落としていくというアルゴリズムである。
\
例えば2で回すときは
\
`4, 6, 8, 10, 12, 14, 16...`
\
は素数ではないので配列から外していく。
\
`2`が終わったのちの、配列中に残る`2`より大きいもっとも小さい数は`3`であり、
\
この時点で`3`は`1`と自身以外に約数を持たないので素数だとわかる。
\
そして素数である`3`について`2`と同様の操作をしていく。


`n`以下の数で素数ではない数は`sqrt(n)`以下の数を必ず約数に持つことから、演習 6同様、この比較は`[sqrt(n)]`まででよい。

#### 疑似コード

```疑似コード
primes_byErat(n): nまでの数のうち素数を返すプログラム
    素数リスト <= 2からnまでの配列
    2からsqrt(n) まで繰り返し => 繰り返し変数i
        j に i * 2 を代入 # i は素数であるため
        j が n より小さいうちは繰り返し
            もし 素数リスト内にjがあったら 素数リストから j を除く # 配列に備わるメソッドdeleteを使用
            j に i を足して代入する
        繰り返し終了
    繰り返し終了
    素数リストを返す
```

#### プログラムとその原理

`Range`オブジェクトである`2..n`を`Array`でキャストして`2..n`までの配列を生成している。
\
`lis.delate()`メソッドは対象要素があればそこを引き抜きその要素を返し、ないときは何もしない(正確には`nil`を返す)メソッドであり、今回のプログラムにおいて利便性が高い。

```ruby
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
```

結果が正しいかを判断するために演習 6で作成したメソッドを使用する。

```ruby
require "./prac6" # 演習 6の関数を読み込む

def checker(lis)
    for i in lis
        if ! i.prime?
            puts "False!!!"
            return
        end
    end
    puts "OK!"
end

checker(primes) # => OK!
```

以下、10秒間にいくつ処理できるかをテストした。

```ruby
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
```

だいたい10秒で`13500`個ほどは処理できることが分かった。
\
以下細かく調査する。

```ruby
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
```

状況が違ったからか、`13500`から減らす方向で実行した場合は`13500`でも10秒を切った。
\
とりあえずこれらの結果より`13500`が10秒以内で実行できる`n`として妥当と判断した。

### その他考察・感想

今回全体を通して言えることは、前回に関してもそうであるが、どのプログラムもどうしても第1、2回で教えられた機能だけでは実現が難しい(または処理が煩雑になる)ということである。
\
逆に言うとRubyには便利な機能が多いともいえることであり、またこれらも実際は分岐や繰り返し処理等の処理が基本となっていることに気を付けたいと思った。(例えば`**`演算子など)

## [アンケート]
- Q1. 枝分かれや繰り返しの動き方が納得できましたか?
    - `times`メソッドはRuby独特なのでまだ使い慣れてない感じがしています。書き方がC言語以上に多いのでうまく使い分けたいなと思います。`if`文に関しては三項演算子を使用して楽をしてすみませんという謎の謝罪をしたいと思います()

- Q2. 枝分かれと繰り返しのどっちが難しいですか? それはなぜ?
    - どっちもどっちだと思いますが、繰り返し変数の中身がわかりにくいという点で繰り返しのほうが初心者には難しいのではないでしょうか? 実際演習 3の繰り返し変数`i`がなぜ`0`始まりなのかの説明は配列の登場を待たねばならず、初心者の方が今回の説明だけで理解できたとはちょっと思えません。
    - どうでもいいことですが隣の人は`elsif`を`else if`(C言語の書き方)にしてしまっていてエラーを起こしていましたね...やっぱり何につまづくかは人それぞれだと思います。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。
    - なんていうか面倒くさい学生ですみません。これからもよろしくお願いします。m(_ _)m
    - 次回も頑張Ruby!! (<- 流行っているらしいですw)