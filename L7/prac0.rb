def bubble_sort(a)
    res = a.dup
    end_i = res.length-1
    done = false
    while !done
        done = true
        (1..end_i).each do |i|
            if res[i-1] > res[i]
                res[i-1], res[i] = res[i], res[i-1]
                done = false
            end
        end
    end
    return res
end

p bubble_sort([3, 4, 2, 5, 1])
# =>