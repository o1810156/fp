# prac5.rbを配列仕様に変更

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

# 昇順に並んだものを特定 -> オーダーは絶対にO(n!)...明らかに無駄が多い

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

# 遅延リストを使えばある程度オーダーを減らせる。
# しかしそれでも最小(元から並んでいる)の比較回数は1回で済むが最大の比較回数はn!回のままであり、
# あまり効率のよいソートとは言い難い。

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