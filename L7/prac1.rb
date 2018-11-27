# a = 1
# b = 2
# テキストの注釈にもあるが、
# rubyでは
# a, b = b, a
# p a
# p b
# でスワップを行うことができるので、特別に
# def swap(a, i, j)
#     x = a[i]; a[i] = a[j]; a[j] = x
# end
# のような関数を用意するのはかえって助長であると考え用意しないこととした。
# C言語の場合はこのような関数またはマクロが必要にはなる。

# a

def arraminrange(a, i, j)
    min_i = i # min index
    (i..j).each do |k|
        if a[k] < a[min_i] then min_i = k end 
    end
    return min_i
end

# b

def selectionsort!(a)
    len = a.length-1
    a.each_index do |i|
        min_i = arraminrange(a, i, len)
        a[i], a[min_i] = a[min_i], a[i]
    end
end

p selectionsort!([3, 4, 2, 5, 1])
# => [1, 2, 3, 4, 5]

# 正直関数を二つ用意するというのは助長であるように感じた。以下で充分である。

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