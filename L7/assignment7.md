# 基礎プログラミングおよび演習レポート ＃07
学籍番号: 1810156
氏名: ** ***
ペア学籍番号・氏名(または「個人作業」): 個人作業
提出日付: 2018/11/27

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L7/assignment7.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- 実行結果は`# =>`のコメントの後に記している場合があります。予めご了承ください。
- 今回の演習において、配列に対し破壊的操作を行う関数にはわかりやすさのためにエクスクラメーション`!`を付けました。また関数名は`snake_case`で付けていることがあります。関数名は基本的にテキストに準拠していますが、適宜変えたという感じです。
- 速度計測に`benchmark`ライブラリを使用しております。いきなり`Benchmark.realtime`が出てくることがありますが、このライブラリを読み込んだうえで実行していることをご了承ください。

## [課題の再掲]

### 演習 1 単純選択法

- a: 配列の`i..j`番目のうち最小値のインデックスを返す関数`arraminrange(a, i, j)`の実装
- b: `arraminrange`を呼び出しながら配列を整列する単純選択法を行う関数`selectionsort(a)`の実装

### 演習 2 単純挿入法

- a: 配列`a`の位置`i`が空いているものとして、位置`i`より前にある`x`より大きい要素を(位置`i`を埋めるように)1つずつ後ろに詰めて行き、最終的な空きの位置を返す関数`shiftlarger(a, i, x)`を実装する
- b: `shiftlarger(a, i, x)`を呼び出しながら単純挿入法で配列を整列する関数`insertionsort(a)`の実装

### 演習 3 処理時間測定

バブルソート、選択ソート、挿入ソートについてデータ数と所要時間の関係を調べる

### 演習 4 マージソート、クイックソート

`mergesort`、`quicksort`を動かし、データ数と所要時間の関係を調べる

### 演習 5 ビンソート

- a: `0~9999`の値がそれぞれ何回現れるかを集計する関数`makebin(a)`を実装する
- b: `makebin(a)`を利用してビンソートを実装する

### 演習 6 基数ソート

基数ソートのプログラムを実装し、データ量と所要時間の関係を調べる

### 演習 7 クイックソートに関するオーダーの考察

整列済み配列を与えると極端に処理時間が大きくなる(計算量が`O(N log N)`から`O(N^2)`になる)ことを計測により確認したうえで、解消する工夫を考える

## [実施したこととその結果]

### 演習 1 単純選択法

#### a `arraminrange(a, i, j)`の実装

`arraminrange`の実装は第3回演習5に近い方法でできる。

現在の最小値インデックス`min_i`が示す最小値`a[min_i]`より小さな要素を発見したら、その要素のインデックスを`min_i`に代入する、という方法を取った。

```ruby
def arraminrange(a, i, j)
    min_i = i # min index
    (i..j).each do |k|
        if a[k] < a[min_i] then min_i = k end 
    end
    return min_i
end
```

#### b `selectionsort(a)`の実装

テキストの注釈にもあるが、rubyでは

```ruby
a, b = b, a
```

でスワップを行うことができるので、特別に

```ruby
def swap(a, i, j)
    x = a[i]; a[i] = a[j]; a[j] = x
end
```

のような関数を用意するのはかえって助長であると考え用意しないこととした。
\
C言語の場合はこのような関数またはマクロが必要にはなる。

```ruby
def selectionsort!(a)
    len = a.length-1
    a.each_index do |i|
        min_i = arraminrange(a, i, len)
        a[i], a[min_i] = a[min_i], a[i]
    end
end

p selectionsort!([3, 4, 2, 5, 1])
# => [1, 2, 3, 4, 5]
```

選択ソートで関数を二つ用意するというのは助長であるように感じた。以下で充分である。

```ruby
def selection_sort(a)
    res = a.dup
    len = res.length-1
    res.each_index do |i|
        ((i+1)..len).each do |j|
            if res[i] > res[j] then res[i], res[j] = res[j], res[i] end
        end
    end
    return res
end

p selection_sort([3, 4, 2, 5, 1])
# => [1, 2, 3, 4, 5]
```

ただしこの書き方は余計なスワップが入るため選択ソートとは言い難い部分もある。また処理時間が増える可能性もある。

### 演習 2 単純挿入法

#### a `shiftlarger(a, i, x)`の実装

`(0..i-1).reverse`を使用することでインデックスを`i-1`から`0`に動かし順に要素を右にスライドさせ、`x`を挿入するべき適切な位置を求めさせた。
\
`j+1`は既に複製が終わった要素を示す。

```ruby
def shiftlarger!(a, i, x)
    (0..i-1).reverse_each do |j|
        if x < a[j]
            a[j+1] = a[j]
        else
            return j+1
        end
    end
    return 0
end
```

#### b `insertionsort(a)`の実装

`0`番目を除く全ての要素に関して左から`shiftlarger`を使用して要素を右にシフトさせつつ適切な位置に挿入させるという操作を行うように実装した。

```ruby
def insertionsort!(a)
    (1..a.length-1).each do |i|
        x = a[i]
        k = shiftlarger!(a, i, x)
        a[k] = x
    end
    return a
end

p insertionsort!([3, 4, 2, 5, 1])
# => [1, 2, 3, 4, 5]
```

演習1同様、サブルーチンを使用しない方法でも書いてみた
\
非破壊的メソッドも実装するという意味を込めている。
\
オーダーは悪化するかもしれないが、直感的にわかりやすいスワップを使用する方法を取ってみた。

```ruby
def insertion_sort(a)
    res = a.dup
    (1..res.length-1).each do |i|
		(0..i-1).reverse_each do |j|
			if res[j+1] < res[j] then res[j+1], res[j] = res[j], res[j+1] end
		end
    end
	return res
end

p insertion_sort([3, 4, 2, 5, 1])
# => [1, 2, 3, 4, 5]
```

### 演習 3 処理時間測定

`prac0.rb`にバブルソート、`prac1`に選択ソート、`prac2`に挿入ソートを用いて計測を比較した

```ruby
require "./prac0"
require "./prac1"
require "./prac2"
require "benchmark"

orig = Array.new(10000) {rand(10000)}

bubble_sort_time = Benchmark.realtime do
	a = orig.dup
	$bubble_sort_res = bubble_sort(a)
end

puts "bubble sort : #{bubble_sort_time}s"

selection_sort_time = Benchmark.realtime do
	a = orig.dup
	selectionsort!(a)
	$selection_sort_res = a
end

puts "selection sort : #{selection_sort_time}s"

insertion_sort_time = Benchmark.realtime do
	a = orig.dup
	insertionsort!(a)
	$insertion_sort_res = a
end

puts "insertion sort : #{insertion_sort_time}s"

if !($bubble_sort_res == $selection_sort_res and $selection_sort_res == $insertion_sort_res)
	puts "CAUTION!! Results are different."
end
# =>
# bubble sort : 8.390783242008183s
# selection sort : 3.4919859109795652s
# insertion sort : 3.428640844009351s

# =>
# bubble sort : 8.978877220011782s
# selection sort : 3.0392261059896555s
# insertion sort : 3.3412723740038928s
```

平均的に選択ソート < 挿入ソート < バブルソートという結果となった。

比較回数に関しては、

```
1回目: N個の要素に対し比較はN-1回
2回目: N-1個の要素に対し比較はN-2回
3回目: N-2個の要素に対し比較はN-3回
・
・

N-1回目: 2個の要素に対し比較は1回
```

であるから2つ分足して2で割ると考えるとすべて`N(N-1)/2`回であるが、
\
バブルソートに関してはほか2回より処理時間が遅くなっていることが確認された。
\
オーダーや比較回数が同じソートでも処理時間が異なるのであると考えられる。

### 演習 4 マージソート、クイックソート

教科書に従いマージソートとクイックソートを実装し、時間計測を行った。
\
一部自分なりのに見やすいようにコードを改変したりしている。

```ruby
require "benchmark"

def merge_sort!(a, i=0, j=a.length-1)
    if j <= i then return end
    
    k = (i + j) / 2
    merge_sort!(a, i, k)
    merge_sort!(a, k+1, j)
    merge(a, i, k, a, k+1, j).each_with_index do |elm, m| a[i+m] = elm end
end

def merge(a1, i1, j1, a2, i2, j2)
    b = []
    while i1 <= j1 or i2 <= j2
        if i1 > j1
            b.push(a2[i2])
            i2 += 1
        elsif i2 > j2
            b.push(a1[i1])
            i1 += 1
        elsif a1[i1] > a2[i2]
            b.push(a2[i2])
            i2 += 1
        else
            b.push(a1[i1])
            i1 += 1
        end
    end
    return b
end

def quick_sort!(a, i=0, j=a.length-1)
    if j <= i then return end
    
    pivot = a[j]
    s = i
    i.step(j - 1) do |k|
        if a[k] <= pivot
            a[s], a[k] = a[k], a[s]
            s += 1
        end
    end
    a[j], a[s] = a[s], a[j]
    quick_sort!(a, i, s-1)
    quick_sort!(a, s+1, j)
end

# 時間計測

3.times do |i|
    a = Array.new(10000) {rand(10000)}
    m_a = a.dup
    q_a = a.dup

    merge_sort_time = Benchmark.realtime do
        merge_sort!(m_a)
    end

    puts "#{i}: merge sort : #{merge_sort_time}s"

    quick_sort_time = Benchmark.realtime do
        quick_sort!(q_a)
    end

    puts "#{i}: quick sort : #{quick_sort_time}s"

    if m_a != q_a
        puts "CAUTION!! Results are different."
    end

    puts "###"
end

# =>
# $ ruby prac4.rb
# 0: merge sort : 0.030882848994224332s
# 0: quick sort : 0.017538082000100985s
# ###
# 1: merge sort : 0.03599437700177077s
# 1: quick sort : 0.02315702399937436s
# ###
# 2: merge sort : 0.03763545300171245s
# 2: quick sort : 0.02162949000194203s
# ###
```

同じ要素数であるのに選択ソート等に比べほぼ100倍の速さとなっている。

`log_2{10000} = 13.2`、`10000/2 = 5000`、`5000/13.2 ≒ 378.9`より、理論値であればもう少し速い速度が出たかもしれないが、
\
このソート内には配列への代入等ソートのオーダーとは関係がない部分でも入出力が行われているため`100`倍は妥当な速度差であると考えられる。

### 演習 5 ビンソート

#### a `makebin(a)`を実装する

仕様通り、配列`a`の範囲`0..a.max`分の要素(要素数`a.max+1`)を格納できる配列`bin`を用意し、
\
配列`a`内の各要素を取り出して個数を`bin`に格納、その後返り値として`bin`を返すように書いた。

```ruby
def make_bin(a, max)
    bin = Array.new(max+1, 0)
    for elm in a
        bin[elm] += 1
    end
    return bin
end
```

#### b `makebin(a)`を利用してビンソートを実装する

`make_bin`を使用して`bin`を作成、そして`bin`の内容を取り出し、回数分実行して配列`a`に格納するように実装した。

```ruby
def bin_sort_prac5!(a, max=10000)
    b = make_bin(a, max)
    j = 0
    (max+1).times do |i|
        b[i].times do
			a[j] = i
			j += 1
        end
    end
end

a = [1, 3, 9, 9, 3, 0, 3, 4, 1, 5, 6, 8, 3, 9, 2, 3, 4, 1, 2, 5, 3, 6, 7, 8, 9, 3, 2, 5, 4, 6, 2, 5, 2, 7, 4, 5]
bin_sort_prac5!(a, a.max)
p a
# =>
# [0, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8, 9, 9, 9, 9]
```

`make_bin`を用意するのは正直くどいのでまとめてみた

Rubyの場合範囲外にアクセスしても「エラーにならない」ので、例外処理はしなかった
\
ただし範囲外にアクセスするとそこまでにあるはずの要素は`nil`になるので、そこは配慮する

```ruby
def bin_sort!(a, max=10000)
	bin = Array.new(max+1, 0)
    for elm in a
        bin[elm] += 1
    end
    j = 0
    (max+1).times do |i|
        bin[i].times do
			a[j] = i
			j += 1
        end
	end
end

a = [1, 3, 9, 9, 3, 0, 3, 4, 1, 5, 6, 8, 3, 9, 2, 3, 4, 1, 2, 5, 3, 6, 7, 8, 9, 3, 2, 5, 4, 6, 2, 5, 2, 7, 4, 5]
bin_sort!(a, a.max)
p a
# =>
# [0, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8, 9, 9, 9, 9]
```

また次の通り処理時間を計測した。

```ruby
require "benchmark"

a = Array.new(10000) {rand(10000)}

3.times do |i|
    bin_sort_time = Benchmark.realtime do
        bin_sort!(a)
    end
    puts "#{i}: bin sort : #{bin_sort_time}s"
end

# =>
# $ ruby prac5.rb
# 0: bin sort : 0.002307874005055055s
# 1: bin sort : 0.00212486699456349s
# 2: bin sort : 0.0021841059933649376s
```

処理時間はマージソート、クイックソートとほぼ同等であった。
\
単純に考えてオーダーは`O(N)`であり、予めバケツの範囲を決めておかなければならないなどの制約はあるものの、効率がよいソートであるといえる。

### 演習 6 基数ソート

`mask`を左シフト(2倍にする演算)しつつ、`mask`と`&`演算をして`0`になったものは`smalls`、`1`になったものは`larges`、という風にして分類した。

```ruby
def radix_sort(a)
    mask = 1
    while true
        counter = 0
        smalls, larges = [], []
        a.each do |elm|
            if elm & mask == 0
                smalls << elm
            else
                larges << elm
                counter += 1
            end
        end
        if counter == 0 then break end # largesに分けられる要素が0のときは整列完了としてループを抜ける
        a = smalls + larges
        mask <<= 1
    end
    return a
end

a = [3, 9, 12, 4, 5, 20, 7]
res = radix_sort(a)
puts "radix sort: #{res}"
# =>
# radix sort: [3, 4, 5, 7, 9, 12, 20]
```

測定も行った。

```ruby
require "benchmark"

a = Array.new(10000) {rand(10000)}

3.times do |i|
    radix_sort_time = Benchmark.realtime do
        res = radix_sort(a)
    end
    puts "#{i}: radix sort : #{radix_sort_time}s"
end
# =>
# 0: radix sort : 0.022283594007603824s
# 1: radix sort : 0.01611703698290512s
# 2: radix sort : 0.019952092989115044s

# =>
# 0: radix sort : 0.016133963013999164s
# 1: radix sort : 0.02052756299963221s
# 2: radix sort : 0.015207286982331425s
```

こちらも基数ソートと同様にデータの種類や範囲等の制約を受けやすいと考えられるが、計測時間よりオーダーは`O(N)`であると考えられる。

### 演習 7 クイックソートに関するオーダーの考察

まずクイックソートで整列済みの配列をソートしてみた。

```ruby
3.times do |i|
    # a = Array.new(10000) {rand(10000)}
    a_sorted = Array.new(10000) {|i| i}
    quick_sort_sorted_time = Benchmark.realtime do
        quick_sort!(a_sorted)
    end

    puts "#{i}: quick sort : #{quick_sort_sorted_time}s"
end
```

しかしこの時はエラーとなった。

```ruby
/fp/L7/prac4.rb:41:in `step': stack level too deep (SystemStackError)
        from /fp/L7/prac4.rb:41:in `quick_sort!'
        from /fp/L7/prac4.rb:48:in `quick_sort!'
        from /fp/L7/prac4.rb:48:in `quick_sort!'
        from /fp/L7/prac4.rb:48:in `quick_sort!'
        from /fp/L7/prac4.rb:48:in `quick_sort!'
        from /fp/L7/prac4.rb:48:in `quick_sort!'
        from /fp/L7/prac4.rb:48:in `quick_sort!'
        from /fp/L7/prac4.rb:48:in `quick_sort!'
         ... 8726 levels...
        from /usr/lib/ruby/2.4.0/benchmark.rb:308:in `realtime'
        from prac7.rb:10:in `block in <main>'
        from prac7.rb:7:in `times'
        from prac7.rb:7:in `<main>'
```

配列の要素数を半分の`5000`にして行ってみたが、かなり処理時間が長くなることが確認された。

```ruby
3.times do |i|
    # a = Array.new(10000) {rand(10000)}
    # 10000だとエラーになってしまったので5000に
    a_sorted = Array.new(5000) {|i| i}
    quick_sort_sorted_time = Benchmark.realtime do
        quick_sort!(a_sorted)
    end

    puts "#{i}: quick sort with sorted : #{quick_sort_sorted_time}s"
end

# =>
# 0: quick sort with sorted : 1.5361140900058672s
# 1: quick sort with sorted : 1.5260927319905022s
# 2: quick sort with sorted : 1.5329557049990399s
```

解決策として、ピボットを再帰ごとにランダムに選ぶようにした。

```ruby
def quick_sort_rand!(a, i=0, j=a.length-1)
    if j <= i then return end
    
    t = rand(i..j)
    a[t], a[j] = a[j], a[t]
    pivot = a[j]
    s = i
    i.step(j - 1) do |k|
        if a[k] <= pivot
            a[s], a[k] = a[k], a[s]
            s += 1
        end
    end
    a[j], a[s] = a[s], a[j]
    quick_sort_rand!(a, i, s-1)
    quick_sort_rand!(a, s+1, j)
end

# a = [3, 9, 12, 4, 5, 20, 7]
# quick_sort_rand!(a)
# puts "quick sort rand: #{a}"

3.times do |i|
    a = Array.new(10000) {rand(10000)}
    quick_sort_rand_time = Benchmark.realtime do
        quick_sort_rand!(a)
    end

    puts "#{i}: quick sort rand: #{quick_sort_rand_time}s"
end

puts "###"

3.times do |i|
    # a = Array.new(10000) {rand(10000)}
    a_sorted = Array.new(10000) {|i| i}
    quick_sort_rand_sorted_time = Benchmark.realtime do
        quick_sort_rand!(a_sorted)
    end

    puts "#{i}: quick sort rand with sorted : #{quick_sort_rand_sorted_time}s"
end

# 0: quick sort rand: 0.018963708993396722s
# 1: quick sort rand: 0.022913367007276975s
# 2: quick sort rand: 0.023256814005435444s
# ###
# 0: quick sort rand with sorted : 0.020327630001702346s
# 1: quick sort rand with sorted : 0.023719799995888025s
# 2: quick sort rand with sorted : 0.021574482001597062s
```

整列前の配列(`Array.new(10000) {rand(10000)}`)の時も整列された配列(`Array.new(10000) {|i| i}`)の時もほぼ同じ時間でソートできるようになった。
\
毎回ピボットをランダムに選ばせることで最悪計算量`O(N^2)`を踏まないようにしている。
\
しかし天文学的な低さではあるが最悪計算量となる可能性は0ではないということなので、クイックソートは完ぺきなソートであるとは言い難いのかもしれない。

## [考察]

同じオーダーのソートでも平均処理時間にばらつきがあることが確認された。比較やスワップ以外にもソートするために行っている処理があり、そこも処理時間に影響していることが原因と考えられる。
\
このことを踏まえると言語や処理系で最適なソートも変わってくるのではないかということが考察される。
\
またオーダーとは関係がない部分で下手な処理をしていないかという点も重要であるということがわかった。

## [アンケート]
Q1. 整列アルゴリズムをいくつくらい理解しましたか。また、それぞれの時間計算量についてはどうですか。

選択ソートは良く書いていました。また概要については基本情報技術者試験等で勉強していたためある程度存じておりました。
\
マージソート、クイックソート、ビンソート、基数ソートに関しては実装したことがなかったので、今回理解を深めることができ良かったです。

Q2. 自分で作れる程度のプログラムについてなら、その時間計算量が求められそうですか?

自分の中では、ループがいくつあるかを見れば大体わかるというイメージです。再帰のときなどは少し注意がいるなと思います。

Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

時間計測に関しては避けては通れぬ道だと思いますので、またこの辺りは復習したいなと思います。次回も頑張Ruby!