# まずすごろくを作成した

$events = [
    lambda {|pos| pos}, # スタート
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos + 5}, # 5進む <- 8に行くと同義であるが忠実に再現
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| 17}, # ワープ
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos - 10},
    lambda {|pos| pos},
    lambda {|pos| pos + 3},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| pos},
    lambda {|pos| 0},
    lambda {|pos| pos}
]

def sugoroku_sim(n = 10000)
    dist_dic = {}
    n.times do
        count = 0
        pos = 0
        while pos < 19
            count += 1
            dice = rand(1..6)
            pos += dice
            if pos < 20 then pos = $events[pos].call(pos) end
        end
        if dist_dic[count] != nil
            dist_dic[count] += 1
        else
            dist_dic[count] = 1
        end
    end
    return dist_dic.inject({}) do |a, (k, v)| a[k] = ("%.3f" % (v / n.to_f * 100) ) + "%" ;a end
end

res = sugoroku_sim
for k, v in res
    puts "#{k}: #{v}"
end

# =>
# 5: 17.690%
# 7: 7.890%
# 11: 3.330%
# 4: 18.270%
# 6: 11.950%
# 3: 14.340%
# 15: 1.030%
# 10: 4.160%
# 17: 0.780%
# 8: 5.930%
# 9: 5.280%
# 16: 0.850%
# 14: 1.500%
# 20: 0.360%
# 13: 1.860%
# 28: 0.050%
# 12: 2.440%
# 23: 0.130%
# 21: 0.350%
# 19: 0.510%
# 24: 0.110%
# 25: 0.140%
# 33: 0.020%
# 26: 0.100%
# 22: 0.260%
# 18: 0.470%
# 38: 0.010%
# 31: 0.050%
# 30: 0.040%
# 27: 0.050%
# 36: 0.010%
# 29: 0.010%
# 35: 0.020%
# 47: 0.010%

# さすがにこれに関しては数学的検証は省略する