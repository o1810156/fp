def pi_random(n)
    count = 0
    n.times do
        x, y = rand(), rand()
        if x ** 2 + y**2 < 1.0 then count += 1 end
    end
    return 4.0 * count / n.to_f
end

for i in 1..9
    t = 10**i
    puts "#{t} => #{pi_random(t)}"
end

# =>
# 10 => 3.2
# 100 => 3.08
# 1000 => 3.172
# 10000 => 3.1116
# 100000 => 3.14676
# 1000000 => 3.14554
# 10000000 => 3.1416292
# 100000000 => 3.14158736
# 1000000000 => 3.141595348

# =>
# 10 => 2.8
# 100 => 3.28
# 1000 => 3.176
# 10000 => 3.1208
# 100000 => 3.1516
# 1000000 => 3.140108
# 10000000 => 3.1415628
# 100000000 => 3.14151236
# 1000000000 => 3.141635568

# 試行回数に比例して有効数字は増えているものの、必ずしも精度が上がるとは限らないということがわかる
# すなわちどこまでが正確な値であるかを判断するのが難しいので実用性に欠ける、といえる。