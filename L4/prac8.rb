# ハノイの塔

# ハノイの塔のルール

# 軸Aにある大きさがすべて異なる真ん中に穴の開いた円形プレートを、3つの軸A、B、Cに関してBを使用しながらAからCへすべて移す。
# 円形プレートは自身より大きいプレートを自身の上に乗せることはできず、始めに軸Aにある状態に関してもこの関係は守られている。
# 円形プレートを乗せられるのは当然軸上だけである。
# 移動は1枚づつしかできない。
# 軸間の円形プレートの移動に上記以外の制約はない。(A -> Cに移すことも可能)

# 解法

# 再帰を利用すれば枚数に関係なく解くことが可能である。以下のように考える。

# 0. まず動かしたいプレートNより下は、そのプレートに乗れないプレートはないので、考えなくてもよい。
# 1. 軸Xから軸Yに動かしたいプレートNより上にあるプレートを作業用の軸Zにすべて移す。
# 2. プレートNを軸Xから軸Yに移動する。
# 3. プレートNより小さいプレートを軸Zから軸Yに軸Xを作業用の軸として移す。
# 4. これを一連の作業とするとどのような組み合わせでも、「枚数 n、出発軸 from、終点軸 destination、作業軸 work」がわかっていれば移動できる。なお1、3はn = 1のとき実行しなくてよい。

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
# =>
# 1をAからCへ
# 2をAからBへ
# 1をCからBへ
# 3をAからCへ
# 1をBからAへ
# 2をBからCへ
# 1をAからCへ