def triarea_f(w, h)
    s = (w * h)/2.0
    return s
end

def triarea_i(w, h)
    s = (w * h)/2
    return s
end

puts triarea_f(1, 1)
# => 0.5
puts triarea_i(1, 1)
# => 0 => 商とあまりで割り算の結果を表す場合の商になっている。(つまり余りが無視されている)