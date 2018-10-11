def abs1(x)
    if x < 0
        result = -x
    else
        result = x
    end
    return result
end

puts "abs1(1) = #{abs1(1)}" # => abs1(1) = 1
puts "abs1(-1) = #{abs1(-1)}" # => abs1(-1) = 1
puts "abs1(12345) = #{abs1(12345)}" # => abs1(12345) = 12345
puts "abs1(-5678) = #{abs1(-5678)}" # => abs1(-5678) = 5678
puts "abs1(0) = #{abs1(0)}" # => abs1(0) = 0

def abs2(x)
    if x < 0
        return -x
    else
        return x
    end
end

puts "abs2(1.2) = #{abs2(1.2)}" # => abs2(1.2) = 1.2
puts "abs2(-2.0) = #{abs2(-2.0)}" # => abs2(-2.0) = 2.0
puts "abs2(-Math::PI) = #{abs2(-Math::PI)}" # => abs2(-Math::PI) = 3.141592653589793
puts "abs2(0) = #{abs2(0)}" # => abs2(0) = 0
# puts "abs2('hoge') = #{abs2('hoge')}"
# =>
# prac1.rb:17:in `<': comparison of String with 0 failed (ArgumentError)
#         from prac1.rb:17:in `abs2'
#         from prac1.rb:28:in `<main>'

def abs3(x)
    result = x
    if x < 0 then result = -x end
    return result
end

puts "abs3(1) = #{abs3(1)}" # => abs3(1) = 1
puts "abs3(-1) = #{abs3(-1)}" # => abs3(-1) = 1
puts "abs3(0) = #{abs3(0)}" # => abs3(0) = 0

def abs4(x) return x<0?-x:x end

puts "abs4(1) = #{abs4(1)}" # => abs4(1) = 1
puts "abs4(-1) = #{abs4(-1)}" # => abs4(-1) = 1
puts "abs4(0) = #{abs4(0)}" # => abs4(0) = 0