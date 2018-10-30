# 基礎プログラミングおよび演習レポート ＃04

学籍番号: 1810156
\
氏名: ** ***
\
ペア学籍番号・氏名(または「個人作業」): 個人作業
\
提出日付: 2018/10/30

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L4/assignment4.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- 実行結果は`# =>`のコメントの後に記している場合があります。予めご了承ください。
- `~~ 省略 ~~`と記し一部ソースコードまたは実行結果を省略していることがあります。
- 実行環境はbashです。(正確にはWindowsのMINGW64)。なおRubyのバージョンは`ruby 2.4.0p0 (2016-12-24 revision 57164) [x86_64-msys]`です。

## [課題の再掲]

### 演習 1 インタラクティブ電卓 a ～ c の機能の実装

- a: 加える代わりに指定した値を引く機能`dec(x)`
- b: うっかり間違って`reset`した時にそれを取り消せる機能`undo`
- c: これまでに加えた(そして引いた)値の一覧を表示した上で合計を表示する機能`list`

### 演習 2 RPN電卓 a ～ eの機能の実装

- a: 減算`sub`、除算`div`、剰余`mod`
- b: 現在の演算結果の符号を反転する操作`inv`
- c: 最後の結果と1つ前の結果を交換する操作`exch`
- d: ご破産の機能`clear`と、開始またはご破産から現在までの操作をすべて横に並べて(つまり`RPN`で)表示する機能`show`
- e: その他、RPN電卓にあったらよいと思う任意の機能 -> 文字列として与えて一気に計算させる機能を実装した。

### 演習 3 2×2のRPN電卓

- a: `2 × 2`行列のRPN電卓を作る
- b: 転置行列、逆行列の演算
- c: `2 × 2`より大きな`3 × 3`、できれば一般の`N × N`行列のRPN電卓を作る

### 演習 4 再帰

- a: 階乗の計算
- b: フィボナッチ数
- c: 組み合わせの数の計算
- d: 正の整数`n`の2進表現

### 演習 5 順列

順列(permutation)を再帰で生成する

### 演習 6 順列ソート

演習5の方法を利用してソートを実装する。なおこのソートの問題点と改善方法について検討する。

### 演習 7 アナグラム

ローマ字で与えられた日本語のアナグラムを作成する。(例: `hoge -> gohe`)

### 演習 8 [自由課題]: ハノイの塔

その他再帰を利用したプログラムの実装
-> 「ハノイの塔」を実装した。

## [実施したこととその結果]

### 演習 1 インタラクティブ電卓

全体のコードは以下の通りとなった。
\
各部分についてはそれぞれの項目にて切り出し、そこで解説する。

```ruby
$x = 0
$pres = []
$list = []
$pre_lists = []

# b

def _save_pre
    $pres.push($x)
end

def sum(v)
    _save_pre()
    $x += v
    $list.push(v)
    return $x
end

def reset
    _save_pre()
    $x = 0
    $pre_lists.push($list.dup)
    $list = []
    return $x
end

# a

def dec(v)
    _save_pre()
    $x -= v
    $list.push(-v)
    return $x
end

# b

def undo
    $x = $pres.length > 0 ? $pres.pop : 0
    return $x
end

# c

def list_sum
    return $list.sum
end

def list_undo
    $list = $pre_lists.pop
    return $list
end
```

#### a 加える代わりに指定した値を引く機能`dec(x)`

`sum`関数の`+=`を`-=`に変えただけである。`a -= b`は`a = a - b`に等しい。

```ruby
def dec(v)
    _save_pre() # b用
    $x -= v
    $list.push(-v) # c用
    return $x
end
```

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac1.rb"
=> true
irb(main):002:0> sum 5
=> 5
irb(main):003:0> dec 2
=> 3
irb(main):004:0>
```

#### b うっかり間違って`reset`した時にそれを取り消せる機能`undo`

```ruby
$pres = []

# ~~ 省略 ~~

def _save_pre
    $pres.push($x)
end

# ~~ 省略 ~~

def undo
    $x = $pres.length > 0 ? $pres.pop : 0
    return $x
end
```

`sum`と`dec`それぞれに前の値を配列に記録する処理`_save_pre`を行わせることで実装した。
\
`undo`を実行すると、配列に履歴があれば`$x`に前の値を設定する。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac1.rb"
=> true
irb(main):002:0> sum 1
=> 1
irb(main):003:0> sum 2
=> 3
irb(main):004:0> dec 5
=> -2
irb(main):005:0> undo
=> 3
irb(main):006:0> undo
=> 1
irb(main):007:0> undo
=> 0
irb(main):008:0> undo
=> 0
irb(main):009:0>
```

`undo`自体を取り消す処理`redo`も考えたが、とりあえず実装は行わなかった(ぉぃ
\
`undo`する際に`$x`の値を別な配列に保存するなどの方法は考えられる。

#### c: これまでに加えた(そして引いた)値の一覧を表示した上で合計を表示する機能`list`

```ruby
$list = []
$pre_lists = []

# ~~ 省略 ~~

def reset
    _save_pre()
    $x = 0
    $pre_lists.push($list.dup)
    $list = []
    return $x
end

# ~~ 省略 ~~

def list_sum
    return $list.sum
end

def list_undo
    $list = $pre_lists.pop
    return $list
end
```

`sum`、`dec`にて`$list.push(v)`のような処理を行わせることで履歴として保存させた。
\
`$pres`は各 **累積結果**で、`$list`は各 **演算数**をそれぞれ表しており、別物である点に注意したい。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac1.rb"
=> true
irb(main):002:0> sum 1
=> 1
irb(main):003:0> sum 2
=> 3
irb(main):004:0> sum 3
=> 6
irb(main):005:0> sum 4
=> 10
irb(main):006:0> $list
=> [1, 2, 3, 4]
irb(main):007:0> list_sum
=> 10
irb(main):008:0> reset
=> 0
irb(main):009:0> $list
=> []
irb(main):010:0> list_undo
=> [1, 2, 3, 4]
irb(main):011:0>
```

### 演習 2 RPN電卓

全体のコードは以下の通りとなった。
\
各部分についてはそれぞれの項目にて切り出し、そこで解説する。

```ruby
$vals = []
$recorder = ""

# d

def _save_recorder(v)
    $recorder += v
end

def e(x)
    $vals.push(x)
    _save_recorder("#{x} ")
    return $vals
end

def add
    $vals.push($vals.pop + $vals.pop)
    _save_recorder("add ")
    return $vals
end

def sub
    $vals.push(-$vals.pop + $vals.pop)
    _save_recorder("sub ")
    return $vals
end

def mul
    $vals.push($vals.pop * $vals.pop)
    _save_recorder("mul ")
    return $vals
end

def div
    x, y = $vals.pop, $vals.pop
    $vals.push(y / x.to_f)
    _save_recorder("div ")
    return $vals
end

def mod
    x, y = $vals.pop, $vals.pop
    $vals.push(y % x)
    _save_recorder("mod ")
    return $vals
end

def inv
    $vals[-1] = -$vals[-1]
    _save_recorder("inv ")
    return $vals
end

def exch
    x, y = $vals.pop, $vals.pop
    $vals.push(x); $vals.push(y)
    _save_recorder("exch ")
    return $vals
end

def clear
    $vals = []
    _save_recorder("clear ")
    return $vals
end

def show
    return $recorder[0..-2] + " = #{$vals.join(' ')}"
end

# 打ち込んだ文字列を逆ポーランド記法と解釈し、一気に演算する関数RPN

$methods = {
    "add" => method(:add),
    "+" => method(:add),
    "sub" => method(:sub),
    "-" => method(:sub),
    "mul" => method(:mul),
    "*" => method(:mul),
    "×" => method(:mul),
    "x" => method(:mul),
    "div" => method(:div),
    "/" => method(:div),
    "÷" => method(:div),
    "mod" => method(:mod),
    "%" => method(:mod),
    "inv" => method(:inv),
    "exch" => method(:exch)
}

def _RPN(str)
    clear()
    fml = str.split
    for tkn in fml
        # if tkn == "e" then next end
        if tkn =~ /-?[1-9]*\d+\.?\d*/
            e Float(tkn)
        elsif $methods.include? tkn
            $methods[tkn].call
        end
    end
    res = $vals.length == 1 ? $vals[0] : $vals
    clear()
    $recorder = ""
    return res
end

def rpn
    print("RPN formula ? ")
    _RPN(STDIN.gets.gsub("\n", ""))
end
```

#### a 減算`sub`、除算`div`、剰余`mod`

```ruby
def sub
    $vals.push(-$vals.pop + $vals.pop)
    _save_recorder("sub ")
    return $vals
end
```

のような感じで、`sum`関数の`$vals.push($vals.pop + $vals.pop)`に当たる部分を各関数の中で適宜変更しただけである。
\
演算の順番に特に気を付けて実装した。また、割り算に関しては`.to_f`メソッドを実行し実数値で計算させた。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac2.rb"
=> true
irb(main):002:0> e 100
=> [100]
irb(main):003:0> e 20
=> [100, 20]
irb(main):004:0> sub
=> [80]
irb(main):005:0> e 2
=> [80, 2]
irb(main):006:0> div
=> [40.0]
irb(main):007:0> e 3
=> [40.0, 3]
irb(main):008:0> mod
=> [1.0]
irb(main):009:0>
```

#### b 現在の演算結果の符号を反転する操作`inv`

```ruby
def inv
    $vals[-1] = -$vals[-1]
    _save_recorder("inv ")
    return $vals
end
```

配列の最後`$vals[-1]`について負にして代入するという処理である。
\
少し横着なコードとなった。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac2.rb"
=> true
irb(main):002:0> e 10
=> [10]
irb(main):003:0> inv
=> [-10]
irb(main):004:0>
```

#### c: 最後の結果と1つ前の結果を交換する操作`exch`

```ruby
def exch
    x, y = $vals.pop, $vals.pop
    $vals.push(x); $vals.push(y)
    _save_recorder("exch ")
    return $vals
end
```

取り出して順に`$vals.push`するだけである。`x`が最後の要素(先に取り出される要素)、`y`が後ろから二つ目の要素(後に取り出される要素)である。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac2.rb"
=> true
irb(main):002:0> e 20
=> [20]
irb(main):003:0> e 10
=> [20, 10]
irb(main):004:0> e 50
=> [20, 10, 50]
irb(main):005:0> exch
=> [20, 50, 10]
irb(main):006:0>
```

#### d ご破産の機能`clear`と、開始またはご破産から現在までの操作をすべて横に並べて(つまり`RPN`で)表示する機能`show`

ご破算`clear`に関しては単に配列を空にした。
\
`show`に関しては各演算にて`_save_recorder("(演算子名) ")`のようなコードを入れ、レコーダを利用することで実装した。

```ruby
def clear
    $vals = []
    _save_recorder("clear ")
    return $vals
end

def show
    return $recorder[0..-2] + " = #{$vals.join(' ')}"
end
```

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac2.rb"
=> true
irb(main):002:0> e 5
=> [5]
irb(main):003:0> e 4
=> [5, 4]
irb(main):004:0> add
=> [9]
irb(main):005:0> e 6
=> [9, 6]
irb(main):006:0> e 7
=> [9, 6, 7]
irb(main):007:0> mul
=> [9, 42]
irb(main):008:0> div
=> [0.21428571428571427]
irb(main):009:0> show
=> "5 4 add 6 7 mul div = 0.21428571428571427"
irb(main):010:0> clear
=> []
irb(main):011:0>
```

#### e その他、RPN電卓にあったらよいと思う任意の機能 -> 文字列として与えて一気に計算させる機能

つまり`8 5 3 × +`や`8 5 + 3 x`、`e -5.4 e -3.2 x`といった文字列を逆ポーランド記法の計算式とみなし、計算する機能を実装した。

```ruby
$methods = {
    "add" => method(:add),
    "+" => method(:add),
    "sub" => method(:sub),
    "-" => method(:sub),
    "mul" => method(:mul),
    "*" => method(:mul),
    "×" => method(:mul),
    "x" => method(:mul),
    "div" => method(:div),
    "/" => method(:div),
    "÷" => method(:div),
    "mod" => method(:mod),
    "%" => method(:mod),
    "inv" => method(:inv),
    "exch" => method(:exch)
}

def _RPN(str)
    clear()
    fml = str.split
    for tkn in fml
        # if tkn == "e" then next end
        if tkn =~ /-?[1-9]*\d+\.?\d*/
            e Float(tkn)
        elsif $methods.include? tkn
            $methods[tkn].call
        end
    end
    res = $vals.length == 1 ? $vals[0] : $vals
    clear()
    $recorder = ""
    return res
end

def rpn
    print("RPN formula ? ")
    _RPN(STDIN.gets.gsub("\n", ""))
end
```

数値チェックは正規表現を用いた。またハッシュを使用することでなるべく条件分岐の部分を簡潔にした。
\
また値が一つか複数(または0)かで返す方法も変えるなどの工夫を施した。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac2.rb"
=> true
irb(main):002:0> rpn
RPN formula ? 8 5 3 × +
=> 23.0
irb(main):003:0> rpn
RPN formula ? 8 5 + 3 x
=> 39.0
irb(main):004:0> rpn
RPN formula ? e -5.4 e -3.2 x
=> 17.28
irb(main):005:0>
```

### 演習 3 2×2のRPN電卓

演習a、bのコードは以下の通りとなった。
\
各部分についてはそれぞれの項目にて切り出し、そこで解説する。

```ruby
$vals = []
$recorder = ""

def _save_recorder(v)
    $recorder += v
end

def e(x)
    $vals.push(x)
    _save_recorder("#{x} ")
    return $vals
end

def add
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] + x[i][j]
	end end
    $vals.push(z)
    _save_recorder("add ")
    return $vals
end

def sub
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] - x[i][j]
	end end
    $vals.push(z)
    _save_recorder("sub ")
    return $vals
end

def mul
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] * x[i][j]
	end end
    $vals.push(z)
    _save_recorder("mul ")
    return $vals
end

# 行列積

def dot
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		d = 0
		for k in 0..1
			d += y[i][k] * x[k][j]
		end
		z[i][j] = d
	end end
	$vals.push(z)
	_save_recorder("dot ")
	return $vals
end

def div
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] / x[i][j].to_f
	end end
    $vals.push(z)
    _save_recorder("div ")
    return $vals
end

def mod
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] % x[i][j]
	end end
    $vals.push(z)
    _save_recorder("mod ")
    return $vals
end

def inv
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = -x[i][j]
	end end
    $vals.push(z)
    _save_recorder("inv ")
    return $vals
end

def exch
    x, y = $vals.pop, $vals.pop
    $vals.push(y); $vals.push(x)
    _save_recorder("exch ")
    return $vals
end

def clear
    $vals = []
    _save_recorder("clear ")
    return $vals
end

def show
    return $recorder[0..-2] + " = #{$vals.join(' ')}"
end

# b 転置行列

def T
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = x[j][i]
	end end
	$vals.push(z)
	_save_recorder("T ")
	return $vals
end

# b 逆行列

def rev
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	m = x[0][0]*x[1][1] - x[0][1]*x[1][0]
	if m == 0
		$vals.push(x) 
		return $vals
	end
	[1, 0].each_with_index do |xi, zi|
		[1, 0].each_with_index do |xj, zj|
			z[zi][zj] = (-1)**(xi+xj) * x[xj][xi] / m.to_f
		end
	end
	$vals.push(z)
	_save_recorder("rev ")
	return $vals
end
```

#### a `2 × 2`行列のRPN電卓を作る

多くは演習2に改良を施しただけである。`dot`積に関しては行列特有のものであるから新たに作成した。(実は第3回appendix1にて触れた内容とほぼ同じである。)

```ruby
def dot
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		d = 0
		for k in 0..1
			d += y[i][k] * x[k][j]
		end
		z[i][j] = d
	end end
	$vals.push(z)
	_save_recorder("dot ")
	return $vals
end
```

`2×2`行列であることがはっきりしている分、値もきっちりと決まっている。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac3.rb"
=> true
irb(main):002:0> e [[1, 2], [3, 4]]
=> [[[1, 2], [3, 4]]]
irb(main):003:0> e [[5, 6], [7, 8]]
=> [[[1, 2], [3, 4]], [[5, 6], [7, 8]]]
irb(main):004:0> add
=> [[[6, 8], [10, 12]]]
irb(main):005:0> e [[2, 2], [2, 2]]
=> [[[6, 8], [10, 12]], [[2, 2], [2, 2]]]
irb(main):006:0> div
=> [[[3.0, 4.0], [5.0, 6.0]]]
irb(main):007:0> e [[1, 2], [3, 4]]
=> [[[3.0, 4.0], [5.0, 6.0]], [[1, 2], [3, 4]]]
irb(main):008:0> dot
=> [[[15.0, 22.0], [23.0, 34.0]]]
irb(main):009:0> e [[10, 10], [10, 10]]
=> [[[15.0, 22.0], [23.0, 34.0]], [[10, 10], [10, 10]]]
irb(main):010:0> sub
=> [[[5.0, 12.0], [13.0, 24.0]]]
irb(main):011:0>
```

#### b 転置行列、逆行列の演算

##### 転置行列

`i行j列`と`j行i列`で対応させるだけである。

```ruby
def T
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = x[j][i]
	end end
	$vals.push(z)
	_save_recorder("T ")
	return $vals
end
```

##### 逆行列

2x2行列の場合以下の式で求められる。

```
A = [[a, b], [c, d]]
A^(-1) = ( 1/(ad-bc) ) * [[d, -b], [-c, a]]
```

この定義に基づいて実装した。

```ruby
def rev
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	m = x[0][0]*x[1][1] - x[0][1]*x[1][0]
	if m == 0
		$vals.push(x) 
		return $vals
	end
	[1, 0].each_with_index do |xi, zi|
		[1, 0].each_with_index do |xj, zj|
			z[zi][zj] = (-1)**(xi+xj) * x[xj][xi] / m.to_f
		end
	end
	$vals.push(z)
	_save_recorder("rev ")
	return $vals
end
```

`(-1)**(xi+xj)`によって、正負の判断を付けている。
```
[[(-1)**0, (-1)**1]
,[(-1)**1, (-1)**2]]
```

また`m = 0`の場合(正則行列でない場合)演算を実行しないように実装した。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac3.rb"
=> true
irb(main):002:0> e [[1, 2], [3, 4]]
=> [[[1, 2], [3, 4]]]
irb(main):003:0> rev
=> [[[-2.0, 1.0], [1.5, -0.5]]]
irb(main):004:0> e [[1, 3], [2, 4]]
=> [[[-2.0, 1.0], [1.5, -0.5]], [[1, 3], [2, 4]]]
irb(main):005:0> T()
=> [[[-2.0, 1.0], [1.5, -0.5]], [[1, 2], [3, 4]]]
irb(main):006:0> dot
=> [[[1.0, 0.0], [0.0, 1.0]]]
irb(main):007:0>
```

#### c `2 × 2`より大きな`3 × 3`、できれば一般の`N × N`行列のRPN電卓を作る

```ruby
$vals = []
$recorder = ""
$n = 2

def config(n) # n×n行列に変更
    $n = n
end

def _save_recorder(v)
    $recorder += v
end

def e(x)
    $vals.push(x)
    _save_recorder("#{x} ")
    return $vals
end

$methods = {
    add: lambda {|a, b| a + b},
    sub: lambda {|a, b| a - b},
    mul: lambda {|a, b| a * b},
    div: lambda {|a, b| a / b.to_f},
    mod: lambda {|a, b| a % b},
}

def _eval(meth)
	x = $vals.pop
	y = $vals.pop
	z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		z[i][j] = $methods[meth].call(y[i][j], x[i][j])
	end end
    $vals.push(z)
    _save_recorder("#{meth} ")
    return $vals
end

def add
    _eval(:add)
end

def sub
    _eval(:sub)
end

def mul
    _eval(:mul)
end

def div
    _eval(:div)
end

def mod
    _eval(:mod)
end

def dot
	x = $vals.pop
	y = $vals.pop
	z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		d = 0
		for k in 0..($n-1)
			d += y[i][k] * x[k][j]
		end
		z[i][j] = d
	end end
	$vals.push(z)
	_save_recorder("dot ")
	return $vals
end

def inv
	x = $vals.pop
    z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		z[i][j] = -x[i][j]
	end end
    $vals.push(z)
    _save_recorder("inv ")
    return $vals
end

def exch
    x, y = $vals.pop, $vals.pop
    $vals.push(y); $vals.push(x)
    _save_recorder("exch ")
    return $vals
end

def T
	x = $vals.pop
	z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		z[i][j] = x[j][i]
	end end
	$vals.push(z)
	_save_recorder("T ")
	return $vals
end

def clear
    $vals = []
    _save_recorder("clear ")
    return $vals
end

def show
    return $recorder[0..-2] + " = #{$vals.join(' ')}"
end

print("次元 ? ")
$n = Integer(STDIN.gets)
```

今回は似たような処理を`_eval`関数にまとめ汎用性を高めた。なお、`2×2`行列のときとのそのほかの相違点は以下である。

- グローバル変数`$n`に`N×N`行列の`N`に当たる情報を格納した。
- 結果を一時的に保存する変数`z`について`z = Array.new($n) {Array.new($n, 0)}`のように宣言することとした。
- 繰り返し回数を指定する`Range`オブジェクトについて、`0..1`ではなく`0..($n-1)`とした。

↓ 実行結果

```bash
$ irb
irb(main):001:0> load "prac3_c.rb"
次元 ? 3
=> true
irb(main):002:0> e [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
=> [[[1, 2, 3], [4, 5, 6], [7, 8, 9]]]
irb(main):003:0> e [[10, 11, 12], [13, 14, 15], [16, 17, 18]]
=> [[[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[10, 11, 12], [13, 14, 15], [16, 17, 18]]]
irb(main):004:0> add
=> [[[11, 13, 15], [17, 19, 21], [23, 25, 27]]]
irb(main):005:0> T()
=> [[[11, 17, 23], [13, 19, 25], [15, 21, 27]]]
irb(main):006:0> e [[3, 3, 3], [3, 3, 3], [3, 3, 3]]
=> [[[11, 17, 23], [13, 19, 25], [15, 21, 27]], [[3, 3, 3], [3, 3, 3], [3, 3, 3]]]
irb(main):007:0> mod
=> [[[2, 2, 2], [1, 1, 1], [0, 0, 0]]]
irb(main):008:0>
```

### 演習 4 再帰

テキストに書かれた定義通りに実装しただけであり特に説明できる点もない。
\
どのように関数が呼び出されているかは図として示した。

#### a 階乗の計算

↓ 呼び出しフロー

```
fact(5)
└-> 5 * fact(4)
		└-> 4 * fact(3)
				└-> 3 * fact(2)
						└-> 2 * fact(1)
								└-> 1
```

↓ 実装

```ruby
def fact(n)
	return n > 1 ? n * fact(n-1) : 1
end

p fact(5) # => 120
```

#### b フィボナッチ数

↓ 呼び出しフロー

```
fib(5)
└-> fib(4)
	└-> fib(3)
		└-> fib(2)
			└-> fib(1)
				└-> 1
			+
			└-> fib(0)
				└-> 1
		+
		└-> fib(1)
			└-> 1
	+
	└-> fib(2)
		└-> fib(1)
			└-> 1
		+
		└-> fib(0)
			└-> 1
+
└-> fib(3)
	└-> fib(2)
		└-> fib(1)
			└-> 1
		+
		└-> fib(0)
			└-> 1
	+
	└-> fib(1)
		└-> 1
```

↓ 実装

```ruby
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
```

#### c 組み合わせの数の計算

↓ 呼び出しフロー

```
comb(5, 3)
└-> comb(4, 3)
	└-> comb(3, 3)
		└-> 1
	+
	└-> comb(3, 2)
		└-> comb(2, 2)
			└-> 1
		+
		└-> comb(2, 1)
			└-> comb(1, 1)
				└-> 1
			+
			└-> comb(1, 0)
				└-> 1
+
└-> comb(4, 2)
	└-> comb(3, 2)
		└-> comb(2, 2)
			└-> 1
		+
		└-> comb(2, 1)
			└-> comb(1, 1)
				└-> 1
			+
			└-> comb(1, 0)
				└-> 1
	+
	└-> comb(3, 1)
		└-> comb(2, 1)
			└-> comb(1, 1)
				└-> 1
			+
			└-> comb(1, 0)
				└-> 1
		+
		└-> comb(2, 0)
			└-> 1
```

↓ 実装

```ruby
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

# ~~ 省略 ~~

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
```

#### d 正の整数`n`の2進表現

↓ 呼び出しフロー

```
binary(5)
└-> binary(2) + "1"
	└-> binary(1) + "0"
		└-> "1"
```

↓ 実装

```ruby
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
```

### 演習 5 順列

```ruby
def perm(a, n, s="")
	if n == 0
		return s
	end

	res = []
	a.each_index do |i|
		nxt = a.dup
		nxt.delete_at(i)
		res.push(*perm(nxt, n-1, s+a[i].to_s))
	end
	return res
end

r = perm([1, 2, 3, 4, 5], 3)

for _p in r
	p _p
end

p r.length
```

条件分岐と再帰を利用して順列を実現した。
\
例えば`perm([1, 2, 3], 2)`は`perm([2, 3], 1, "1")`などを呼び出す。
\
さらに`perm([2, 3], 1, "1")`は`perm([3], 0, "12")`などを呼び出す。
\
`perm([3], 0, "12")`は`n = 0`であるから、`"12"`を返す。こうして返された文字列は`perm([3], 0, "12")`に配列として集約され、
\
さらに`perm([1, 2, 3], 2)`に集約される。このようにして順列は生成される。

↓ 実行結果

```
"123"
"124"
"125"
"132"
"134"

~~ 省略 ~~

"532"
"534"
"541"
"542"
"543"
60
```

### 演習 6 順列ソート

`prac5.rb`を配列仕様に変更したのち、単純に隣り合った要素同士の大小関係を確かめることでソートした。

```ruby
# オーダー計測用
$perm_order = 0

def perm(a, n, r=[])
	if n == 0
        $perm_order += 1
        return r
	end

	res = []
	a.each_index do |i|
		nxt = a.dup
		nxt.delete_at(i)
        p = perm(nxt, n-1, r + (a[i].class == Array ? a[i] : [a[i]]) )
        if p[0].class == Array
            res.push(*p)
        else
            res.push(p)
        end
	end
    return res
end

def perm_sort(a)
    for r in perm(a, a.length)
        flag = false
        for i in 1..r.length-1
            flag = true
            if r[i-1] > r[i]
                flag = false
                break
            end
        end
        if flag then return r end
    end
end
```

全ての要素を配列に書き出すため、オーダーは絶対に`O(n!)`以上となる。これは明らかに無駄が多い

遅延リストを使えばある程度オーダーを減らせる。
\
しかしそれでも最小(元から並んでいる)の比較回数は`1`回で済むが最大の比較回数は`n!`回のままであり、
\
あまり効率のよいソートとは言い難い。

```ruby
# オーダー計測用
$perm_gen_order = 0

def perm_gen(a, n, r=[])
    if n == 0
        return Enumerator.new do |y|
            $perm_gen_order += 1
            y << r
        end
    end

    return Enumerator.new do |y|
        a.each_index do |i|
            nxt = a.dup
            nxt.delete_at(i)
            perm_gen(nxt, n-1, r + (a[i].class == Array ? a[i] : [a[i]]) ).each do |item|
                y << item
            end
        end
    end
end

# perm_gen([0, 1, 2, 3], 2).each {|item|
#     p item
# }

# 遅延リストを用いたソートの実装

def perm_gen_sort(a)
    for r in perm_gen(a, a.length)
        flag = false
        for i in 1..r.length-1
            flag = true
            if r[i-1] > r[i]
                flag = false
                break
            end
        end
        if flag then return r end
    end
end
```

↓ 以下比較である。

```ruby
p perm_sort([2, 4, 1, 3, 5])
puts "perm_order: #{$perm_order}" # => perm_order: 120 # 最悪計算量

p perm_gen_sort([2, 4, 1, 3, 5])
puts "perm_gen_order: #{$perm_gen_order}" # => perm_gen_order: 51 # 半分ほどで済んでいる。

$perm_order = 0
$perm_gen_order = 0

# 既に昇順で並んでいる場合遅延リストならオーダーは1

p perm_sort([1, 2, 3, 4, 5])
puts "perm_order: #{$perm_order}" # => perm_order: 120

p perm_gen_sort([1, 2, 3, 4, 5])
puts "perm_gen_order: #{$perm_gen_order}" # => perm_gen_order: 1

$perm_order = 0
$perm_gen_order = 0

# 既に降順で並んでいる場合共に最悪計算量となる

p perm_sort([5, 4, 3, 2, 1])
puts "perm_order: #{$perm_order}" # => perm_order: 120

p perm_gen_sort([5, 4, 3, 2, 1])
puts "perm_gen_order: #{$perm_gen_order}" # => perm_gen_order: 120
```

### 演習 7 アナグラム

```ruby
require "./prac6"

def anagram(name)
    # 正規表現を使用して母音で分ける
    name_arr = name.split(/([aiueo])/)
    vowels = name_arr.select {|elm| elm =~ /[aiueo]/}
    consos = name_arr.select {|elm| !(elm =~ /[aiueo]/)}
    consos = consos.map {|elm| elm != "" ? elm : "@"}

    res = []
    for vs in perm(vowels, vowels.length)
        vs.insert(0, "@")
        for cs in perm(consos, consos.length)
            t = ""
            cs.each_with_index do |s, i|
                t += vs[i] + s
            end
            t += vs[-1]
            res << t.gsub(/@/, "")
        end
    end

    return res
end

for a in anagram("hogefuga")
    puts a
end

for a in anagram("oohashi")
    puts a
end
```

正規表現を利用して母音と子音で分け、個数の辻褄を`@`で合わせることでローマ字としての整合性を保ちつつアナグラムを作成した。
\
順列の生成には演習6で作成した関数`perm`を使用した。

↓ 実行結果

```
hogefuga
hogegufa
hofeguga
hofeguga
hogegufa

~~ 省略 ~~

gahufego
gaguhefo
gagufeho
gafuhego
gafugeho
oohashi
ooshahi
ohoashi
ohoshai
oshoahi

~~ 省略 ~~

shiahoo
shiaoho
shiahoo
shihaoo
shihaoo
```

### 演習 8 ハノイの塔

～ ハノイの塔のルール ～

- 軸Aにある大きさがすべて異なる真ん中に穴の開いた円形プレートを、3つの軸A、B、Cに関してBを使用しながらAからCへすべて移す。
- 円形プレートは自身より大きいプレートを自身の上に乗せることはできず、始めに軸Aにある状態に関してもこの関係は守られている。
- 円形プレートを乗せられるのは当然軸上だけである。
- 移動は1枚づつしかできない。
- 軸間の円形プレートの移動に上記以外の制約はない。(A -> Cに移すことも可能)

～ 解法 ～

再帰を利用すれば枚数に関係なく解くことが可能である。以下のように考える。

0. まず動かしたいプレート`N`より下は、そのプレートに乗れないプレートはないので、考えなくてもよい。
1. 軸`X`から軸`Y`に動かしたいプレート`N`より上にあるプレートを作業用の軸Zにすべて移す。
2. プレート`N`を軸`X`から軸`Y`に移動する。
3. プレート`N`より小さいプレートを軸`Z`から軸`Y`に軸`X`を作業用の軸として移す。
4. これを一連の作業とするとどのような組み合わせでも、「枚数`n`、出発軸`from`、終点軸`destination`、作業軸`work`」がわかっていれば移動できる。なお`1、3`は`n = 1`のとき実行しなくてよい。

この解法に基づくとコードは以下のようになる。

```ruby
def move(n, frm, dest)
    puts "#{n}を#{frm}から#{dest}へ"
end

def hanoi(n, frm, dest, work)
    if n >= 1
        hanoi(n-1, frm, work, dest)
        move(n, frm, dest)
        hanoi(n-1, work, dest, frm)
    end
end

hanoi(3, "A", "C", "B")
```

↓ 実行結果

```
1をAからCへ
2をAからBへ
1をCからBへ
3をAからCへ
1をBからAへ
2をBからCへ
1をAからCへ
```

## [考察]

前半のRPN電卓などに関しては、似たような処理を複数書いてしまい、助長な表現となってしまった点を改善したいと思った。
\
後半の再帰処理は効率よく実装できたといえる。コードを減らすために再帰を書いている、という部分もあるので、可読性も考慮して実装を行いたいところである。
\
最後のハノイの塔のプログラムは、再帰を使用しないとなると相当解くのに苦戦すると考えられる。このように「再帰じゃないと解けない(または解きにくい)」状況がある場合というのに目ざとくなりたい。

## [アンケート]

- Q1. 手続きが使いこなせるようになりましたか。

授業で取り組んだアルゴリズム等に関してはすべて一通りできるようになったと思います。

- Q2. 再帰的な呼び出しについてはどうですか。

処理を簡潔に書けるので好きですが、`for`ループ等を使用したほうがパフォーマンスが向上する可能性も考えつつ使用したいと思います。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

いつも通り、今回の演習に関しては特にですが、例外処理に関しては全く考慮しておりません。。個人的には演習3より前にはフールプルーフ等をもう少し用意するべきだったかなと思いました。
\
そういえばテキストには例外処理に関する記述がほとんど見られませんが、「基礎プログラミングおよび演習」においては扱わないということなのでしょうか?少し気になりました。
\
次回も頑張Ruby!