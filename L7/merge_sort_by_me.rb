def merge_sort(a)
    res = Array.new(a.length) {|i| [a[i]] }

    def merge(a, b)
        # p a
        # p b
        merged = []
        while a.length > 0 or b.length > 0
            if a.length == 0
                merged << b.pop
            elsif b.length == 0
                merged << a.pop
            else
                merged << (a[-1] < b[-1] ? a.pop : b.pop)
            end
        end
        merged.reverse!
        return merged
    end

    while res.length > 1
        new_res = []
        (res.length/2).times do
            new_res << merge(*res.pop(2))
        end
        tmp = res.pop
        if tmp then new_res << tmp end
        res = new_res
        p res.reverse
        sleep(1)
    end

    return res[0].reverse
end

# p merge_sort([3, 5, 2, 6, 7, 1, 8, 0, 9])
p [1, 1, 4, 5, 1, 4, 1, 9, 1, 9, 8, 1, 0]
sleep(1)
p merge_sort([1, 1, 4, 5, 1, 4, 1, 9, 1, 9, 8, 1, 0])
sleep(1)