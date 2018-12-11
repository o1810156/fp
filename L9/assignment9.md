# 基礎プログラミングおよび演習レポート #09
学籍番号: 1810156
氏名: ** ***
ペア学籍番号・氏名(または「個人作業」): 個人作業
提出日付: 2018/12/11

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L9/assignment9.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- 実行結果は`# =>`のコメントの後に記しています。予めご了承ください。

## [課題の再掲]

### 演習 2 クラスの作成

次の機能を持つクラスを実装する

- a:  「覚える」機能を持つクラス`Memory`。`put(x)`で与えた容を記憶し、`get`で取り出す。
- b: 「文字列を連結していく」クラス`Concat`。`add(s)`で文字列`s`を今まで覚えているものに連結する。`get`で現在覚えている文字列を返す。`reset`で覚えている文字列を空文字列にリセット。
- c: 「最大2つ覚える」機能を持つクラス`Memory2`。`put(x)`で新しい内容を記憶させ、`get`で取り出す。2回取り出すと 2回目はより古い内容が出てくる。取り出した値は忘れる。覚えている以上に取り出すと`nil`が返る。「最大 N 個覚える」も時間があれば行う。

### 演習 3 有理数クラス

テキストにある有理数クラスをそのまま打ち込んで動かす。動いたら、四則の他の演算も追加し、動作を確認する。できれば、これを用いて浮動小数点では正確に行えない「実用的な」計算が正確にできることを確認する。

### 演習 4 複素数クラス

複素数(complex number)を表すクラス`Comp`を定義し、動作を確認する。これを用いて何らかの役に立つ計算をしてみる。

### 演習 5 [自由課題]

[自由課題] 今回は行列クラス`Matrix`を実用的なものとして、まとめた。

## [実施したこととその結果]

### 演習 2

#### a Memoryクラス

フィールド`@mem`に`nil`を置く初期化関数`initialize`、`@mem`のセッターに当たる`put`、ゲッターに当たる`get`を定義した。

```ruby
class Memory
	def initialize
		@mem = nil
	end
	def put(m)
		@mem = m
	end
	def get
		return @mem
	end
end

m1 = Memory.new
p m1.put(5) # => 5
p m1.get # => 5
p m1.get # => 5
p m1.put(10) # => 10
p m1.get # => 10
```

動作を確認することができた。

#### b Concatクラス

文字列を保存するフィールド`s`、文字列の仕切りとなるフィールド`d`を置く初期化関数`initialize`、文字列を追加するメソッド`add`、`s`のゲッターに当たる`get`、文字列をリセットする`reset`、仕切りを変更するセッター`set_deli`を定義した。

```ruby
class Concat
	def initialize(s = "", d = "")
		@mem = s
		@deli = d
	end
	def add(s)
		@mem += @deli + s
	end
	def get
		return @mem
	end
	def reset
		@mem = ""
	end
	def set_deli(d)
		@deli = d
	end
end

c = Concat.new
p c.add("This") # => "This"
p c.add("is") # => "Thisis"
p c.get # => "Thisis"
p c.add("a") # => "Thisisa"
p c.reset # => ""
p c.add("pen") # => "pen"
p c.get # => "pen"
```

デリミタを指定してみた。

```ruby
c = Concat.new("This")
c.set_deli(" ")
# c.add("This") # <= デフォルト値として設定させる
c.add("is")
c.add("a")
c.add("pen")
p c.get # => "This is a pen"
```

自然な結合ができる。

#### c Memory2クラス と MemoryNクラス

`Memory`に対して、記憶領域に当たるフィールドを`mem_arr`として配列で保存させた。
\
名前に関して、`get`とは明らかに挙動が違うので`pop`に改めた。

```ruby
class Memory2
	def initialize
		@mem_arr = Array.new
	end
	# def get
	def pop # 忘れるならpopの方がいい
		return @mem_arr.pop # 最大数より多く取り出すとnilになるのでこれでよい
	end
	def put(x)
		if @mem_arr.length >= 2
			@mem_arr[0], @mem_arr[1] = @mem_arr[1], x
		else
			@mem_arr.push(x)
		end
	end
end

m2 = Memory2.new
m2.put("knyssは")
m2.put("FP2018のラスボス")
p m2.pop # => "FP2018のラスボス"
m2.put("天才")
p m2.pop # => "天才"
p m2.pop # => "knyssは"
p m2.pop # => nil
```

2つまでしか覚えられないことが確認できる。

```ruby
m2.put("hoge")
m2.put("fuga")
m2.put("bar")
m2.put("baz")
p m2.pop # => "baz"
p m2.pop # => "bar"
p m2.pop # => nil
p m2.pop # => nil
```

3つ以上記憶できるように改良した。

```ruby
class MemoryN
	def initialize(n)
		@mem_len = n
		@mem_arr = Array.new
	end
	def pop
		return @mem_arr.pop
	end
	def put(x)
		if @mem_arr.length >= @mem_len
			(@mem_len-1).times do |i|
				@mem_arr[i] = @mem_arr[i+1]
			end
			@mem_arr[@mem_len-1] = x
		else
			@mem_arr.push(x)
		end
	end
end

m3 = MemoryN.new(3)
m3.put("knyssは")
m3.put("FP2018のラスボスで")
m3.put("天才ハカー")
p m3.pop # => "天才ハカー"
m3.put("アイコンが棒人間")
p m3.pop # => "アイコンが棒人間"
p m3.pop # => "FP2018のラスボスで"
p m3.pop # => "knyssは"
p m3.pop # => nil
```

この場合は3つまでしか覚えられないことが確認できる。

```ruby
m3.put("hoge")
m3.put("fuga")
m3.put("bar")
m3.put("baz")
p m3.pop # => "baz"
p m3.pop # => "bar"
p m3.pop # => "fuga"
p m3.pop # => nil
```

### 演習 3 有理数クラス

テキストの`Ratio`クラスにほかの四則演算とべき乗を定義した。

```ruby
class Ratio
	def initialize(a, b = 1)
		@a = a
		@b = b
		if b == 0 # 分母が0なら
			@a = 1 # aを1とする
			return
		end
		if a == 0 # 分子が0なら
			@b = 1
			return
		end
		if b < 0
			@a = -a
			@b = -b
		end
		g = gcd(a.abs, b.abs); @a = @a/g; @b = @b/g
	end

	def getDivisor
		return @b
	end
	def getDividend
		return @a
	end

	def to_s
		if @b == 1
			return "#{@a}"
		else
			return "#{@a}/#{@b}"
		end
	end

	def +(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*d + @b*c, @b*d) # a/b+c/d = (ad+bc)/bd
	end

	def -(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*d - @b*c, @b*d) # a/b-c/d = (ad-bc)/bd
	end

	def *(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*c, @b*d) # a/b * c/d = a*c / b*d
	end

	def /(r)
		c = r.getDividend; d = r.getDivisor
		return Ratio.new(@a*d, @b*c) # a/b / c/d = a*d / b*c
	end

	def **(n)
		return Ratio.new(@a**n, @b**n)
	end

	def gcd(x, y) # 第3回 演習2 参考
		while true do
			if x > y
				x = x % y
				if x == 0
					return y
				end
			else
				y = y % x
				if y == 0
					return x
				end
			end
		end
	end
end
```

以下動作確認である。

```ruby
x = Ratio.new(15, 3)
puts x # => 5

a = Ratio.new(3, 5)
b = Ratio.new(8, 7)

puts "#{a} + #{b} = #{a + b}"
puts "#{a} - #{b} = #{a - b}"
puts "#{a} * #{b} = #{a * b}"
puts "#{a} / #{b} = #{a / b}"
puts "#{a} ^ 5 = #{a**5}"

# =>
# 3/5 + 8/7 = 61/35
# 3/5 - 8/7 = -19/35
# 3/5 * 8/7 = 24/35
# 3/5 / 8/7 = 21/40
# 3/5 ^ 5 = 243/3125

c = Ratio.new(3, 5)
d = Ratio.new(2, 5)

puts "#{c} + #{d} = #{c + d}"
puts "#{c} - #{d} = #{c - d}"
puts "#{c} * #{d} = #{c * d}"
puts "#{c} / #{d} = #{c / d}"
puts "#{c} ^ 5 = #{c**5}"

# =>
# 3/5 + 2/5 = 1
# 3/5 - 2/5 = 1/5
# 3/5 * 2/5 = 6/25
# 3/5 / 2/5 = 3/2
# 3/5 ^ 5 = 243/3125
```

浮動小数点では正確に行えない実用的な計算をしてみた。
\
このように情報落ちを防ぐことができる。

```ruby
puts "10**10 + 1e-10 = #{10**10 + 1e-10}"
puts "Ratio.new(10**10, 1) + Ratio.new(1, 10**10) = #{Ratio.new(10**10, 1) + Ratio.new(1, 10**10)}"

# =>
# 10**10 + 1e-10 = 10000000000.0
# Ratio.new(10**10, 1) + Ratio.new(1, 10**10) = 100000000000000000001/10000000000
```

#### 演習 4 複素数クラス

複素数クラス`Comp`を定義した。演習3と同様に四則演算とべき乗を定義した。
\
ただしべき乗に関しては、せっかくなのでド・モアブルの定理を用いた。

その他にも以下のことを行った。

- 実部を取得するメソッド`getRe`、虚部を取得するメソッド`getIm`、絶対値を取得するメソッド`abs`、偏角を取得するメソッド`arg`を定義した。
- 表示をよくするために、`Integer`と`Float`クラスに`rnd`メソッドを追加した。
- 自身を複製するメソッド`dup`(これは`Array`クラスに習っている)、自身を文字に変換するメソッド`to_s`を定義した。

```ruby
class Integer
    def rnd(n)
        return self
    end
end

class Float
    def rnd(n)
        return self.round(n)
    end
end

class Comp
	def initialize(r, i)
		@r = r
		@i = i
	end

	def getRe
		return @r
    end

	def getIm
		return @i
    end
    
    def abs
        return Math::sqrt(@r**2 + @i**2)
    end

    def dup
        return Comp.new(@r, @i)
    end

    def to_s
        r_s = @r != 0 ? @r.rnd(3).to_s : ""
        if @i == 0
            i_s = ""
        elsif @i.abs != 1
            i_s = @i > 0 && @r != 0 ? "+" + @i.rnd(3).to_s + "i" : @i.rnd(3).to_s + "i"
        else
            if @i > 0
                i_s = @r != 0 ? "+i" : "i"
            else
                i_s = "-i"
            end
        end
        return r_s + i_s
	end

    def +(c)
        cr = c.getRe
        ci = c.getIm
		return Comp.new(@r+cr, @i+ci)
	end

    def -(c)
        cr = c.getRe
        ci = c.getIm
		return Comp.new(@r-cr, @i-ci)
	end

	def *(c)
        cr = c.getRe
        ci = c.getIm
        t = Comp.new(@r * cr, @r * ci)
        u = Comp.new(-(@i * ci), @i * cr)
        return t + u
	end

	def /(c)
        cr = c.getRe
        ci = c.getIm
        d = ((c.abs)**2).to_f # Denominator 分母
        t = Comp.new(cr, -ci)
        n = self * t # Numerator
        return Comp.new(n.getRe/d.to_f, n.getIm/d.to_f)
	end

    # 通常の実装では以下

    # def **(n)
    #     res = self.dup
    #     if n % 2 == 0
    #         res = self**(n/2) * self**(n/2)
    #     else
    #         res = self * self**(n-1)
    #     end
    #     return res 
    # end

    # 折角なので極方程式を使用する

    def arg
        if @i > 0
            return Math::acos(@r / self.abs.to_f)
        else
            return Math::acos(-@r / self.abs.to_f) + Math::PI
        end
    end

    def **(n)
        r = self.abs ** n
        t = (n*self.arg) % (2*Math::PI)
        return Comp.new(r * Math::cos(t), r * Math::sin(t))
    end
end

def Re(c)
    return c.getRe
end

def Im(c)
    return c.getIm
end

def arg(c)
    return c.arg
end

fomulas = ["a", "b", "c",
"a + b", "a - c", "a * c", "a - c * b",
"a.abs",
"a.arg / Math::PI",
"a**5",
"(c - b) / (a - b)"]

fomulas.each do |f|
    a = Comp.new(-1, -1)
    b = Comp.new(0, 1)
    c = Comp.new(1, -2)
    res = eval(f)
    puts "#{f} = #{res}"
end

# =>
# a = -1-i
# b = i
# c = 1-2i
# a + b = -1
# a - c = -2+i
# a * c = -3+i
# a - c * b = -3-2i
# a.abs = 1.4142135623730951
# a.arg / Math::PI = 1.25
# a**5 = 4.0+4.0i
# (c - b) / (a - b) = 1.0+1.0i
```

複素数を使用すると、行列について考えることなく回転を簡単に記述できる。これを利用して正方形を回転させてみた。

```ruby
PI4C = Comp.new(Math::cos(Math::PI/4.0), Math::sin(Math::PI/4.0))
PI8C = Comp.new(Math::cos(Math::PI/8.0), Math::sin(Math::PI/8.0))

# 45°回した場合

sq1 = [[1, 1], [-1, 1], [-1, -1], [1, -1]].map do |pos|
    res = Comp.new(pos[0], pos[1]) * PI4C
    [Re(res).round(3), Im(res).round(3)]
end

p sq1

# 22.5°回した場合

sq2 = [[1, 1], [-1, 1], [-1, -1], [1, -1]].map do |pos|
    res = Comp.new(pos[0], pos[1]) * PI8C
    [Re(res).round(3), Im(res).round(3)]
end

p sq2

# =>
# [[0.0, 1.414], [-1.414, 0.0], [0.0, -1.414], [1.414, 0.0]]
# [[0.541, 1.307], [-1.307, 0.541], [-0.541, -1.307], [1.307, -0.541]]
```

期待した通りの値となった。

### 演習 5 行列クラス

今回は演習3、4に習う形で行列クラスを作成した。実は第3回でもおまけとして作成していたが、今回は第3回とは別に新たに作成した。(書き終わったのちに重複に気が付いた...)

以下のような特徴がある。

- 四則演算に加え、行列積を求める`dot`メソッド、転置行列を求める`T`メソッドを定義した。(`T`は`numpy`というモジュールにならって命名した。)

- 第3回より発展させた内容として、行列の簡約化も行えるようにした(echelonizeメソッド)。簡約化はよく使うのでできると非常に便利である。

- 演習4と同様に表示のために`Integer`クラスと`Float`クラスに`rnd`メソッドを追加した。また演習3、4との相違点として、四則演算は処理内容が非常に似通ったので、共通部分に関してメソッド`op`を定義してまとめた。こうすることで何か変更が生じた場合も修正を1箇所で済ませることができる。

- 文字列化するメソッド`to_s`のほかに、`inspect`メソッドも追加した。このメソッドは`p`関数(主にデバッグに使用できる、オブジェクトなどを表示する関数)での表示形態を指定できるというものである。

```ruby
class Integer
    def rnd(n)
        return self
    end
end

class Float
    def rnd(n)
        return self.round(n)
    end
end

class Matrix
    def initialize(arr)
        if not arr.is_a? Array or
                not arr[0].is_a? Array or
                arr.any? {|row| row.length != arr[0].length} then
            raise ArgumentError
        end

        @mat = arr
        @row_num = arr.length
        @col_num = arr[0].length
    end

    attr :mat, :row_num, :col_num

    def inspect
        return "[[" + (@mat.map do |r| r = r.map do |v| v.rnd(3) end; r.join(", ") end).join("],\n [") + "]]"
    end

    def to_s
        return @mat.to_s
    end

    def op(o, m)
        if not m.is_a? Matrix then raise ArgumentError, "need Matrix" end
        if m.row_num != @row_num or m.col_num != @col_num then raise ArgumentError, "sizes were not matched:\nrow: #{@row_num} | #{m.row_num}\ncol: #{@col_num} | #{m.col_num}" end
        
        res = m.mat.map.with_index do |r, i|
            r.map.with_index do |v, j|
                @mat[i][j].method(o).call(v)
            end
        end

        return Matrix.new(res)
    end

    def +(m)
        return self.op(:+, m)
    end

    def -(m)
        return self.op(:-, m)
    end

    def *(m)
        if m.is_a? Numeric
            return Matrix.new(@mat.map do |r| r.map do |v| m * v end end)
        else
            return self.op(:*, m)
        end
    end

    def /(m)
        if m.is_a? Numeric
            return Matrix.new(@mat.map do |r| r.map do |v| v / m.to_f end end)
        else
            m = m.mat.map do |row| row.map do |v| v.to_f end end
            return self.op(:/, Matrix.new(m))
        end
    end

    def T # 転置
        res = []
        @col_num.times do |j|
            row = []
            @row_num.times do |i|
                row.push(@mat[i][j])
            end
            res.push(row)
        end
        return Matrix.new(res)
    end

    def echelonize # 簡約化
        res = @mat.dup
        j = 0
        @col_num.times do |j|
            i_ori = j
            i = i_ori
            while i_ori < @row_num
                while i < @row_num
                    k = res[i][j]
                    if k == 0
                        i += 1
                        next
                    end
                    
                    @row_num.times do |i2|
                        if res[i2][j] == 0
                            next
                        elsif i2 == i
                            res[i] = res[i].map do |v| v / k.to_f end
                        else
                            t = res[i2][j] / k.to_f
                            j.step(@col_num-1) do |j2|
                                res[i2][j2] -= res[i][j2] * t
                            end
                        end
                    end
                    res[i_ori], res[i] = res[i], res[i_ori]
                    i += 1
                end
                i_ori += 1
            end
        end
        return Matrix.new(res)
    end

    def dot(m) # 行列積
        if @col_num != m.row_num then
            raise ArgumentError, "a.dot(b): a.col_num and b.row_num are must be same.\na.col_num: #{@col_num}\nb.row_num: #{m.row_num}"
        end

        res = []
        @row_num.times do |i|
            row = []
            m.col_num.times do |j|
                v = 0
                @col_num.times do |k|
                    v += @mat[i][k] * m.mat[k][j]
                end
                row.push(v)
            end
            res.push(row)
        end

        return Matrix.new(res)
    end
end

a = Matrix.new([[-1, 1, 0], [3, 0, 4]])
b = Matrix.new([[1, 0], [-2, 1], [3, 2]])
c = Matrix.new([[3], [2], [-1]])

d = Matrix.new([[1, 2, 3], [4, 5, 6]])

# 四則演算

p a + d
p a - d
p a * d
p a / d

# =>
# [[0, 3, 3],
#  [7, 5, 10]]
# [[-2, -1, -3],
#  [-1, -5, -2]]
# [[-1, 2, 0],
#  [12, 0, 24]]
# [[-1.0, 0.5, 0.0],
#  [0.75, 0.0, 0.667]]

# 転置

p a.T

# =>
# [[-1, 3],
#  [1, 0],
#  [0, 4]]

# 簡約化

p a.echelonize

g = Matrix.new(
    [[2, 0, 3, 2],
     [3, 1, 0, 1],
     [0, -2, 9, 4],
     [1, 1, 3, 1]]
)

p g.echelonize

# =>
# [[1.0, 0.0, 1.333],
#  [-0.0, 1.0, 1.333]]
# [[1.0, 0.0, 0.0, 0.5],
#  [-0.0, 1.0, 0.0, -0.5],
#  [0.0, -0.0, 1.0, 0.333],
#  [-0.0, 0.0, 0.0, 0.0]]

# 行列積

def dot_homework(a, b)
    begin
        puts "#{a}・#{b} = #{a.dot(b)}"
    rescue ArgumentError
        puts "#{a}・#{b} -> 定義されない"
    end
end

ta = a.T
tb = b.T
tc = c.T

p ta
p tb
p tc

mats = [a, b, c, ta, tb, tc]

for m in mats
    for n in mats
        dot_homework(m, n)
    end
end

# 結果は第3回 appendix1と同様なので省略。
# 第3回 appendix1はこちらからご覧いただけます。
# https://github.com/o1810156/fp/blob/master/L3/appendix1.rb
```

## [考察]

今回はオブジェクト指向のうちでも大切な要素である「隠蔽」や「継承」といった機能にはあまり触れなかったように見えるが、地味に登場している。

「隠蔽」(カプセル化)は主にゲッターとセッターを用意する形で使用していた。ただし今回は範囲や規則を指定したりといったカプセル化による恩恵はあまり使用しなかったといえる。Unity等でゲームを作成するときは非常に重要な要素である。

「継承」は一見登場していないように見えるが、演習5にて`m.is_a? Numeric`という形で登場している。継承関係を与えることで、「実数」や「整数」に対して「数」といった人間的な捉え方をすることが可能になる。このように書けることはオブジェクト指向の目的の一つといえる。

今回はオブジェクト指向に関して深く考察をした。
\
ただ「もの(オブジェクト)」っぽく考えるのがオブジェクト指向である、ととらえないように、なぜオブジェクト指向で書くのか、なぜクラスを定義するべきか(あるいはしなくていいか)に注意を払いながら使っていきたい。

## [アンケート]

- Q1. クラス定義が書けるようになりましたか。

第3回あたりから普通に使っていましたね笑

- Q2. オブジェクト指向について納得しましたか。

ええ、まぁ。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

次回はRubyですが、さらに次の回からはC言語ということでオブジェクト指向使いませんよね笑
\
なんというかもったいない気がします。

とりあえず次回も頑張Ruby!