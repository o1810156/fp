# a
def quadraticSol(a, b, c)
	d = b**2 - 4*a*c
    if d < 0 then raise ArgumentError, "判別式が負になりました。" end
    return [(-b + Math.sqrt(d)) / ((2*a).to_f), (-b - Math.sqrt(d)) / ((2*a).to_f)]
end

p quadraticSol(1, 2, 1) # => [-1.0, -1.0] # (x+1)^2 = 0 の解なので正解
p quadraticSol(1, 0, -1) # => [1.0, -1.0] # (x-1)(x+1) = 0 の解なので正解
#p quadraticSol(1, 2, 3)
# =>
# prac_1_4.rb:4:in `quadraticSol': 判別式が負になりました。 (ArgumentError)
#	from prac_1_4.rb:10:in `<main>'
# x^2 + 2x + 3 = 0 の解なのでエラーで正解

# b (x + h)(x + 1) = x^2 + (h + 1)x + h にてhが小さいとき、4ac ≒ 0よりb ≒ sqrt{d} となるから桁落ちが予想される。
p quadraticSol(1, 1+10**(-5), 10**(-5)) # => [-1.0000000000010001e-05, -1.0] # そこまで桁落ちはひどくない
p quadraticSol(1, 1+10**(-10), 10**(-10)) # => [-1.000000082740371e-10, -1.0] # 少しひどくなってくる
p quadraticSol(1, 1+10**(-15), 10**(-15)) # => [-1.0547118733938987e-15, -1.0] # 桁落ちがはっきりとみられる
p quadraticSol(1, 1+10**(-20), 10**(-20)) # => [0.0, -1.0] # rubyの演算処理によりほぼ0とみなされてしまった。

# printfで桁を指定して出力
printf("[%.30f, %1.0f]\n", *quadraticSol(1, 1+10**(-5), 10**(-5))) # => [-0.000010000000000010000889005823, -1]
printf("[%.30f, %1.0f]\n", *quadraticSol(1, 1+10**(-10), 10**(-10))) # => [-0.000000000100000008274037099909, -1]
printf("[%.30f, %1.0f]\n", *quadraticSol(1, 1+10**(-15), 10**(-15))) # => [-0.000000000000001054711873393899, -1]
printf("[%.50f, %1.0f]\n", *quadraticSol(1, 1+10**(-20), 10**(-20))) # => [0.00000000000000000000000000000000000000000000000000, -1] # 完全に桁落ちしている。

# c 比較的近い値による演算を行わないために桁落ちが起きないβと、解の性質 αβ = c/a を利用して、桁落ちを回避する
def quadraticSol_cor(a, b, c)
	d = b**2 - 4*a*c
    if d < 0 then raise ArgumentError, "判別式が負になりました。" end
    # return [(-b + Math.sqrt(d)) / ((2*a).to_f), (-b - Math.sqrt(d)) / ((2*a).to_f)]
    beta = (-b - Math.sqrt(d)) / ((2*a).to_f)
    alpha = c / (a*beta) # 解の性質より
    return [alpha, beta]
end

# d
printf("[%.30f, %1.0f]\n", *quadraticSol_cor(1, 1+10**(-5), 10**(-5))) # => [-0.000010000000000000000818030539, -1]
printf("[%.30f, %1.0f]\n", *quadraticSol_cor(1, 1+10**(-10), 10**(-10))) # => [-0.000000000100000000000000003643, -1]
printf("[%.30f, %1.0f]\n", *quadraticSol_cor(1, 1+10**(-15), 10**(-15))) # => [-0.000000000000001000000000000000, -1]
printf("[%.30f, %1.0f]\n", *quadraticSol_cor(1, 1+10**(-20), 10**(-20))) # => [-0.000000000000000000010000000000, -1]

# 上記に示す通り酷い桁落ちは観測されなかった