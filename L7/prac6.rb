def radix_sort(a)
    mask = 1
    while true
        counter = 0
        smalls, larges = [], []
        a.each do |elm|
            if elm & mask == 0
                smalls << elm
            else
                larges << elm
                counter += 1
            end
        end
        if counter == 0 then break end
        a = smalls + larges
        mask <<= 1
    end
    return a
end

a = [3, 9, 12, 4, 5, 20, 7]
res = radix_sort(a)
puts "original: #{a}"
puts "radix sort: #{res}"
# =>
# original: [3, 9, 12, 4, 5, 20, 7]
# radix sort: [3, 4, 5, 7, 9, 12, 20]

require "benchmark"

a = Array.new(10000) {rand(10000)}

3.times do |i|
    radix_sort_time = Benchmark.realtime do
        res = radix_sort(a)
    end
    puts "#{i}: radix sort : #{radix_sort_time}s"
end
