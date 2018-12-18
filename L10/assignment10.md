# 基礎プログラミングおよび演習レポート #10

学籍番号: 1810156
\
氏名: ** ***
\
ペア学籍番号・氏名(または「個人作業」): 個人作業
\
提出日付: 2018/12/18

## レポートに関する注意点等(お願い)

- 今回もマークダウン記法を多用しています。
- 見やすさを考慮し本レポートと全く同じ内容を[Githubレポジトリ](https://github.com/o1810156/fp/blob/master/L10/assignment10.md)に用意しました。もし見づらいと感じられた場合はこちらからお願いします。
- 実行結果は`# =>`のコメントの後に記しています。予めご了承ください。

## [課題の再掲]

### 演習 1 リスト構造の理解と諸メソッドの実装

テキストにあるリストの例を実行し理解したのち、以下のメソッドを実装する。

- a: `data`に数値が入っている単連結リストに対して、その数値の合計を求める`listsum`
- b: 各セルの`data`(文字列)を連結した1つの文字列を返す`listcat`
- c: 上と同様だがただし逆順に連結する`listcatrev`
- d: `printlist`と同様だが、1行目は1回、2行目は2回、3行目は4回、…と倍倍で打ち出す回数が増える`printmany`
- e: `listsum`と同様だが、ただし奇数番目のセルの値だけ合計する`listoddsum`
- f: 単リストの並び順を逆向きにした単リストを返す`listrev`

### 演習 3 単連結リストのエディタバッファ

テキストにある`Buffer`クラスを打ち込み、動作を確認したのち以下の操作を追加する。

- a: 現在行を削除する`delete`
- b: 現在行と次の行の順序を交換する`shift`
- c: 1つ前の行に戻る`backward`
- d: すべての行の順番を逆順にする`invert!`

### 演習 4 双連結リストのエディタバッファ

双連結リストで`Buffer`クラス(便宜上`Bbuffer`(Both buffer)としている)を作成し、単連結リストとの得失を考察する。

## [実施したこととその結果]

### 演習 1 リスト構造の理解と諸メソッドの実装

テキストの内容に続き、以下のように予めリストを作成しておいた。

```ruby
list_A = atol([0, 1, 2, 3])
list_B = atol(["A", "B", "C", "D"])
```

#### a 合計値を求める

「現在の値 + 残りのリストの和」という形の再帰を用いて合計値を求める関数`listsum`を実装した。

```ruby
def listsum(ptr)
    if ptr != nil
        return ptr.data + listsum(ptr.next)
    else
		return 0
    end
end

p listsum(list_A) # => 6
```

#### b 文字列連結

aとほぼ同じように再帰を利用して実装した。`ptr == nil`であるときの値に気を付けた。

```ruby
def listcat(ptr)
    if ptr != nil
        return ptr.data.to_s + listcat(ptr.next)
    else
		return ""
    end
end

p listcat(list_B) # => "ABCD"
```

#### c bの逆順

文字列なので、単純に足す順番を逆にするだけで逆順となる。

```ruby
def listcatrev(ptr)
    if ptr != nil
        return listcatrev(ptr.next) + ptr.data.to_s
    else
		return ""
    end
end

p listcatrev(list_B) # => "DCBA"
```

#### d 行ごとに倍に表示

引き続き再帰による実装を行った。第二引数に表示する回数を指定するようにし、再帰呼び出しでその値が倍になるようにした。

```ruby
def printmany(ptr, i=1)
    if ptr != nil
        puts ptr.data.to_s * i
        printmany(ptr.next, i*2)
    end
end

printmany(list_B)

# =>
# A
# BB
# CCCC
# DDDDDDDD
```

#### e 奇数番目だけ合計する

次のように`list_C`を予め定義しておいた。

```ruby
# list_C = atol(Array.new(10) do |i| i+1 end) # => 1..10
list_C = atol(Array(1..10))
```

次の次をたどる方式でまず実装した。他の再帰と異なり、`ptr.next`に関しても`nil`チェックを行った。

```ruby
def listoddsum(ptr)
    if ptr != nil && ptr.next != nil
        # puts "+#{ptr.data}"
        return ptr.data + listoddsum(ptr.next.next)
    else
		return 0
    end
end

# 1 + 3 + 5 + 7 + 9
p listoddsum(list_C) # => 25
```

相互再帰でも実装してみた。奇数のときに呼び出される`listoddsum_odd`、偶数のときに呼び出される`listodddsum_eve`にわけ、奇数のときだけ値が足されるようにした。

```ruby
def listoddsum_odd(ptr)
    if ptr != nil
        # puts "+#{ptr.data}"
        return ptr.data + listoddsum_eve(ptr.next)
    else
        return 0
    end
end

def listoddsum_eve(ptr)
    if ptr != nil
        return listoddsum_odd(ptr.next)
    else
        return 0
    end
end

p listoddsum_odd(list_C) # => 25
```

#### f 逆順の単リストを返す

`atol`を参考に作成した。`atol`においてリストは「後ろから」作られるということを利用し、元となるリストは頭から、作成するリストは後ろから作成されるようにすることで、ちょうど逆順となるようにした。

```ruby
def listrev(ptr)
    res = nil
    while ptr != nil
        res = Cell.new(ptr.data, res)
        ptr = ptr.next
    end
    return res
end

list_C_rev = listrev(list_C)
# printlist(list_C)
printlist(list_C_rev)
# =>
# 10
# 9
# 8
# 7
# 6
# 5
# 4
# 3
# 2
# 1
```

### 演習 3 単連結リストのエディタバッファ

テキストに書かれている範囲を含め、全体像は以下のようになった。

```ruby
class Buffer
    Cell = Struct.new(:data, :next)

    def initialize
        @tail = @cur = Cell.new("EOF", nil)
        @head = @prev = Cell.new("", @cur)
    end

    def inspect
        ptr = @head.next
        while ptr != nil
            printf("#{ptr.data}\\n")
            ptr = ptr.next
        end
        puts
    end

    def at_end?
        return @cur == @tail
    end

    def top
        @prev = @head
        @cur = @head.next
    end

    def forward
        if at_end? then return end
        @prev = @cur
        @cur = @cur.next
    end

    def insert(s)
        @prev.next = Cell.new(s, @cur)
        @prev = @prev.next
    end

    def print
        puts(" " + @cur.data)
    end

    def print_all
        ptr = @head.next
        while ptr != nil
            puts ptr.data
            ptr = ptr.next
        end
    end

    def delete
        # res = @cur
        if @cur.next != nil # == `if @cur.data == "EOF" then return end`
            @prev.next, @cur = @cur.next, @cur.next
        end
        # return res.data
    end

    def shift
        if @cur.next != nil and @cur.next.next != nil
            a = @cur
            b = @cur.next
            a.next, b.next = b.next, a
            @cur, @prev.next = b, b
        end
        return @cur.data
    end

    def backward
        if @cur == @head then return end
        # 頭から探索しなおすしかない。
        # 各リストを区別する値はnextの中身なのでこれを利用する
        ptr = @head
        while ptr.next != nil
            if ptr.next == @prev
                @prev, @cur = ptr, @prev
                break
            end
            ptr = ptr.next
        end
        return @cur.data
    end

    # 演習 1を流用

    def invert!
        res = Cell.new("EOF", nil)
        ptr = @head.next # 先頭はダミーだったのでその次
        while ptr.next != nil
            res = Cell.new(ptr.data, res)
            ptr = ptr.next
        end
        @head = Cell.new("", res) # ダミーを先頭につける
    end
end
```

それぞれの演習内容について解説していく。

#### a delete

```ruby
def delete
    # res = @cur
    if @cur.next != nil # == `if @cur.data == "EOF" then return end`
        @prev.next, @cur = @cur.next, @cur.next
    end
    # return res.data
end
```

前のセルの次に現在のセルの次を、現在のセルにも現在のセルの次を代入することで、リンクを消し実質的に削除した。
\
`@cur.next`が`nil`かどうかを確かめることで`EOF`を誤って削除しないようにした。

#### b shift

```ruby
def shift
    if @cur.next != nil and @cur.next.next != nil
        a = @cur
        b = @cur.next
        a.next, b.next = b.next, a
        @cur, @prev.next = b, b
    end
    return @cur.data
end
```

交換対象セルの`next`を調べることで`EOF`ではないかを判断し、交換対象セルを便宜上`a`、`b`とおいて交換している。

#### c backward

```ruby
def backward
    if @cur == @head then return end
    ptr = @head
    while ptr.next != nil
        if ptr.next == @prev
            @prev, @cur = ptr, @prev
            break
        end
        ptr = ptr.next
    end
    return @cur.data
end
```

`prev`より前は直接は取得できないため、頭から探索しなおすしかない。
\
各リストを区別する値は`next`の中身なのでこれを利用した。
\
`prev`と`ptr.next`の値が一致した時にひとつづつ前にずらすようにした。

オーダーの観点から考えると、単連結リストは逆に辿るのが弱いということは一目瞭然であるといえる。

#### d invert!

演習1fを、エディタバッファに適する形へと変えることで実装した。
\
特に先頭のダミーセルと末尾のEOFセルに関し整合性を保つよう、ループの前後にて処理をしている。

```ruby
def invert!
    res = Cell.new("EOF", nil)
    ptr = @head.next # 先頭はダミーだったのでその次
    while ptr.next != nil
        res = Cell.new(ptr.data, res)
        ptr = ptr.next
    end
    @head = Cell.new("", res) # ダミーを先頭につける
end
```

### 演習 4 双連結リストのエディタバッファ

演習 3の内容を双連結リストによる実装に作り替えた。

```ruby
class Bbuffer # Both Buffer
    Bcell = Struct.new(:data, :prev, :next) # Both Cell -> Bcell

    def initialize
        @tail = @cur = Bcell.new("EOF", nil, nil)
        @head = Bcell.new("", nil, @cur) # prevが不要となった
        @cur.prev = @head
    end

    def inspect
        ptr = @head.next
        while ptr != nil
            printf("#{ptr.data}\\n")
            ptr = ptr.next
        end
        puts
    end

    def at_end?
        return @cur == @tail
    end

    def at_top?
        return @cur == @head.next
    end

    def top
        @cur = @head.next
    end

    def forward
        if at_end? then return end
        @cur = @cur.next
    end

    def backward # 楽に実装できた
        if at_top? then return end
        @cur = @cur.prev
    end

    def insert(s)
        new_cell = Bcell.new(s, @cur.prev, @cur)
        @cur.prev.next, @cur.prev = new_cell, new_cell
    end

    def print
        puts(" " + @cur.data)
    end

    def print_all
        ptr = @head.next
        while ptr != nil
            puts ptr.data
            ptr = ptr.next
        end
    end

    def delete
        # res = @cur
        if @cur.next != nil # == `if @cur.data == "EOF" then return end`
            @cur.prev.next = @cur.next
            @cur.next.prev = @cur.prev
            @cur = @cur.next
        end
        # return res.data
    end

    def shift # すべて書き換えなければならないので演習3より実装が大変である。
        if @cur.next == nil then return end
        a, b, c, d = @cur.prev, @cur, @cur.next, @cur.next.next
        a.next = c
        c.prev, c.next = a, b
        b.prev, b.next = c, d
        d.prev = b
        @cur = b
        return @cur
    end

    # 時間の都合上invert!は実装しなかった。
    # def invert!
    
    # end
end
```

各セルが`prev`を持っているおかげで、`backward`の実装が楽になった。オーダーの観点を考えても単連結リストの弱点を克服できているように思われる。
\
しかしながら、データ構造が複雑化したために、単連結リストのような「単純構造である」という利点は完全になくなってしまったといえる。
\
特に、リスト構造の特徴である「挿入が簡単」や「順序入れ替えが容易」といった点がむしろ悪化している。
\
実際にコードを組んだ時も間違った結果に何度かなってしまい、デバッグ作業に苦労した。

保守性に関しては単連結リストに分があるといえる。

## [考察]

リスト構造はコンピュータ内部でも用いられることがあるほど重要なものであり、構造自体はとても単純であるということが挙げられる。
\
プログラミング言語LISPに用いられている構造であるという特徴もある。

途中にデータを挿入するのが簡単というのが配列と比べて良い点である。今回、再帰などを含め一通りリストの操作方法を学ぶことができ良かった。

## [アンケート]

- Q1. 何らかの動的データ構造が扱えるようになりましたか。

単結合リストを使うことはできるようになりました。

- Q2. 複雑な構造をクラスの中にパッケージ化する利点について納得しましたか。

一度クラス内部で実装してしまえば、外側では内部を気にせずに使用できるというのは、コードを共有したりする上でもとても利便性が高いものであると認識しております。
\
しかし内部にバグがあると面倒なことにつながるという欠点も持ち合わせていると思われます。

- Q3. リフレクション(今回の課題で分かったこと)・感想・要望をどうぞ。

今回でRubyが終わりました。。次回からはRubyより難しいC言語なので、気を引き締めて取り組んでいきたいと思います！