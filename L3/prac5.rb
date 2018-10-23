# a

# arr.max に等しい
def max_in_arr(arr)
    m = arr[0]
    for elm in arr[1..-1]
        if elm > m then m = elm end
    end
    return m
end

puts "max_in_arr([0, 1, 2]) = #{max_in_arr([0, 1, 2])}"
puts "max_in_arr([1, 2, 0]) = #{max_in_arr([1, 2, 0])}"
puts "max_in_arr([2, 1, 0]) = #{max_in_arr([2, 1, 0])}"
puts "max_in_arr([0, 1, 2, 2]) = #{max_in_arr([0, 1, 2, 2])}"
# =>
# max_in_arr([0, 1, 2]) = 2
# max_in_arr([1, 2, 0]) = 2
# max_in_arr([2, 1, 0]) = 2
# max_in_arr([0, 1, 2, 2]) = 2

# b

# arr.index(a.max) に等しい
def index_of_max(arr)
    ind = 0
    arr.each_with_index do |elm, i|
        if elm > arr[ind] then ind = i end # 比較演算子を>=にすると最後を取ってくる
    end
    return ind
end

puts "index_of_max([0, 1, 2]) = #{index_of_max([0, 1, 2])}" # =>
puts "index_of_max([1, 2, 0]) = #{index_of_max([1, 2, 0])}" # => 
puts "index_of_max([2, 1, 0]) = #{index_of_max([2, 1, 0])}" # =>
puts "index_of_max([2, 1, 0, 2]) = #{index_of_max([2, 1, 0, 2])}" # =>
# =>
# index_of_max([0, 1, 2]) = 2
# index_of_max([1, 2, 0]) = 1
# index_of_max([2, 1, 0]) = 0
# index_of_max([2, 1, 0, 2]) = 0

# c

# デフォルトの方法にはない模様
def indexs_of_max(arr)
    inds = []
    m = max_in_arr(arr) # 複数ある場合を考慮すると先に最大値を取るほうが早い
    arr.each_with_index do |elm, i|
        if elm == m then inds.push(i) end
    end
    return inds
end

puts "indexs_of_max([0, 1, 2]) = #{indexs_of_max([0, 1, 2])}" # =>
puts "indexs_of_max([1, 2, 0]) = #{indexs_of_max([1, 2, 0])}" # =>
puts "indexs_of_max([2, 1, 0]) = #{indexs_of_max([2, 1, 0])}" # =>
puts "indexs_of_max([2, 1, 0, 2]) = #{indexs_of_max([2, 1, 0, 2])}" # =>
# =>
# indexs_of_max([0, 1, 2]) = [2]
# indexs_of_max([1, 2, 0]) = [1]
# indexs_of_max([2, 1, 0]) = [0]
# indexs_of_max([2, 1, 0, 2]) = [0, 3]

# d

# デフォルトの方法にはないと思われる(要検索)
def unders_of_ave(arr)
    s = 0
    for elm in arr
        s += elm
    end
    ave = s / arr.length.to_f
    unders = []
    for elm in arr
        if elm < ave then unders.push(elm) end
    end
    return unders
end

puts "unders_of_ave([1, 4, 5, 11]) = #{unders_of_ave([1, 4, 5, 11])}"
puts "unders_of_ave(Array(0..10)) = #{unders_of_ave(Array(0..10))}"
puts "unders_of_ave([1, 1, 4, 5, 1, 4]) = #{unders_of_ave([1, 1, 4, 5, 1, 4])}"
# =>
# unders_of_ave([1, 4, 5, 11]) = [1, 4, 5]
# unders_of_ave(Array(0..10)) = [0, 1, 2, 3, 4]
# unders_of_ave([1, 1, 4, 5, 1, 4]) = [1, 1, 1]

# e

# arr.sortに等しい。
# 今回は選択ソートで実装した。(他のソートに関してはほかの回で言及されているので)
def select_sort(arr)
    res = Array.new(arr.length) {|i| arr[i]} # コピー
    # res = arr.dup # コピー
    len = res.length-1
    for i in 0..len
        for j in i+1..len
            if res[i] > res[j] then res[i], res[j] = res[j], res[i] end
        end
    end
    return res
end

puts "select_sort([4, 11, 5, 1]) = #{select_sort([4, 11, 5, 1])}"
puts "select_sort([1, 3, 0, 2]) = #{select_sort([1, 3, 0, 2])}"
puts "select_sort([1, 2, 0, 2]) = #{select_sort([1, 2, 0, 2])}"
# =>
# select_sort([4, 11, 5, 1]) = [1, 4, 5, 11]
# select_sort([1, 3, 0, 2]) = [0, 1, 2, 3]
# select_sort([1, 2, 0, 2]) = [0, 1, 2, 2]