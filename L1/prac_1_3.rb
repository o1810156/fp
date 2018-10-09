# a
def plus(a, b)
    return a + b
end

def minus(a, b)
    return a - b
end

def product(a, b)
    return a * b
end

def quotient(a, b)
    return a / b.to_f
end

puts plus(1, 2) # => 3
puts minus(1, 2) # => -1
puts product(1, 2) # => 2
puts quotient(1, 2) # => 0.5

# classで再定義が可能らしい...

class Integer
    def +(other)
        return "#{self} たす #{other}"
    end
    def -(other)
        return "#{self} ひく #{other}"
    end
    def *(other)
        return "#{self} かける #{other}"
    end
    def /(other)
        return "#{self} わる #{other}"
    end
end

puts plus(1, 2) # => 1 たす 2
puts minus(1, 2) # => 1 ひく 2
puts product(1, 2) # => 1 かける 2
puts quotient(1, 2) # => 1 わる 2.0
puts quotient(2, 1) # => 2 わる 1.0

# 割り算、なんで実数になってる?

# b
def q(a, b)
    return a % b
end

puts q(10, 6) # => 4
puts q(-10, 6) # => 2 # マイナス値でも定義がなされている！