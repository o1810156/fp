def three_dice_sim(n = 10000)
    win = 0
    n.times do
        dice_a = rand(1..6)
        dice_b = rand(1..6)
        dice_c = rand(1..6)
        cond1 = not(dice_a == dice_b and dice_b == dice_c and dice_c == dice_a)
        cond2 = (dice_a == dice_b or dice_b == dice_c or dice_c == dice_a)
        if cond1 and cond2
            win += 1
        end
    end
    return win / n.to_f
end

p three_dice_sim

# =>
# 0.4127
# 0.4232
# 0.4194

# ↓ 実際の確率を求める(例によって数学はやりたくないのでプログラムで)

def three_dice_dist(n = 10000)
    win = 0
    for i in 1..6
        for j in 1..6
            for k in 1..6
                cond1 = not(i == j and j == k and k == i)
                cond2 = (i == j or j == k or k == i)
                if cond1 and cond2
                    win += 1
                end
            end
        end
    end
    return win / 216.0
end

p three_dice_dist

# =>
# 0.4166666666666667

# シミュレーションは大体うまくいっていることが確認できる。