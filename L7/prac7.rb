require "./prac4"

puts "## ここからprac7 ##"

# 既に整列した配列を使用してソート

# 3.times do |i|
#     # a = Array.new(10000) {rand(10000)}
#     a_sorted = Array.new(10000) {|i| i}
#     quick_sort_sorted_time = Benchmark.realtime do
#         quick_sort!(a_sorted)
#     end

#     puts "#{i}: quick sort : #{quick_sort_sorted_time}s"
# end

# /home/namni/Desktop/fp_home/L7/prac4.rb:41:in `step': stack level too deep (SystemStackError)
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:41:in `quick_sort!'
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:48:in `quick_sort!'
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:48:in `quick_sort!'
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:48:in `quick_sort!'
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:48:in `quick_sort!'
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:48:in `quick_sort!'
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:48:in `quick_sort!'
#         from /home/namni/Desktop/fp_home/L7/prac4.rb:48:in `quick_sort!'
#          ... 8726 levels...
#         from /usr/lib/ruby/2.4.0/benchmark.rb:308:in `realtime'
#         from prac7.rb:10:in `block in <main>'
#         from prac7.rb:7:in `times'
#         from prac7.rb:7:in `<main>'

3.times do |i|
    # a = Array.new(10000) {rand(10000)}
    # 10000だとエラーになってしまったので5000に
    a_sorted = Array.new(5000) {|i| i}
    quick_sort_sorted_time = Benchmark.realtime do
        quick_sort!(a_sorted)
    end

    puts "#{i}: quick sort with sorted : #{quick_sort_sorted_time}s"
end

# 0: quick sort with sorted : 1.5361140900058672s
# 1: quick sort with sorted : 1.5260927319905022s
# 2: quick sort with sorted : 1.5329557049990399s

puts "###"

# pivotをランダムに投げてみた

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