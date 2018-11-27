require "./prac0"
require "./prac1"
require "./prac2"
require "benchmark"

orig = Array.new(10000) {rand(10000)}

bubble_sort_time = Benchmark.realtime do
	a = orig.dup
	$bubble_sort_res = bubble_sort(a)
end

puts "bubble sort : #{bubble_sort_time}s"

selection_sort_time = Benchmark.realtime do
	a = orig.dup
	selectionsort!(a)
	$selection_sort_res = a
end

puts "selection sort : #{selection_sort_time}s"

insertion_sort_time = Benchmark.realtime do
	a = orig.dup
	insertionsort!(a)
	$insertion_sort_res = a
end

puts "insertion sort : #{insertion_sort_time}s"

if !($bubble_sort_res == $selection_sort_res and $selection_sort_res == $insertion_sort_res)
	puts "CAUTION!! Results are different."
end

### 自前で用意した関数で行った場合

# =>
# bubble sort : 11.193594784999732s
# selection sort : 7.640412929002196s
# insertion sort : 12.144450567953754s

# =>
# bubble sort : 8.17215744103305s
# selection sort : 4.772696450992953s
# insertion sort : 6.864161746983882s

### こっちが正しい

# =>
# bubble sort : 8.390783242008183s
# selection sort : 3.4919859109795652s
# insertion sort : 3.428640844009351s

# =>
# bubble sort : 8.978877220011782s
# selection sort : 3.0392261059896555s
# insertion sort : 3.3412723740038928s