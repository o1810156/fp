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

def make_bin(a, max)
    bin = Array.new(max+1, 0)
    for elm in a
        bin[elm] += 1
    end
    return bin
end

# a = [1, 3, 9, 9, 3, 0, 3, 4, 1, 5, 6, 8, 3, 9, 2, 3, 4, 1, 2, 5, 3, 6, 7, 8, 9, 3, 2, 5, 4, 6, 2, 5, 2, 7, 4, 5]
# bin_sort_prac5!(a, a.max)
# p a
# =>
# [0, 1, 1, 1, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 5, 6, 6, 6, 7, 7, 8, 8, 9, 9, 9, 9]

# make_binを用意するのは正直くどいのでまとめてみた

# Rubyの場合範囲外にアクセスしても「エラーにならない」ので、例外処理はしなかった
# ただし範囲外にアクセスするとそこまでにあるはずの要素はnilになるので、そこは配慮する

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

# 速度計算

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