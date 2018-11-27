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

# 演習1同様、サブルーチンを使用しない方法でも書いてみた
# 非破壊的メソッドも実装するという意味を込めている。
# オーダーは悪化するかもしれないが、直感的にわかりやすいスワップを使用する方法を取ってみた。

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
