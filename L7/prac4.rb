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

# a = [3, 9, 12, 4, 5, 20, 7]
# merge_sort!(a)
# puts "merge sort: #{a}"

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

# a = [3, 9, 12, 4, 5, 20, 7]
# quick_sort!(a)
# puts "quick sort: #{a}"

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