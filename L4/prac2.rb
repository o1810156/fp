$vals = []
$recorder = ""

# d

def _save_recorder(v)
    $recorder += v
end

def e(x)
    $vals.push(x)
    _save_recorder("#{x} ")
    return $vals
end

def add
    $vals.push($vals.pop + $vals.pop)
    _save_recorder("add ")
    return $vals
end

def sub
    $vals.push(-$vals.pop + $vals.pop)
    _save_recorder("sub ")
    return $vals
end

def mul
    $vals.push($vals.pop * $vals.pop)
    _save_recorder("mul ")
    return $vals
end

def div
    x, y = $vals.pop, $vals.pop
    $vals.push(y / x.to_f)
    _save_recorder("div ")
    return $vals
end

def mod
    x, y = $vals.pop, $vals.pop
    $vals.push(y % x)
    _save_recorder("mod ")
    return $vals
end

def inv
    $vals[-1] = -$vals[-1]
    _save_recorder("inv ")
    return $vals
end

def exch
    x, y = $vals.pop, $vals.pop
    $vals.push(x); $vals.push(y)
    _save_recorder("exch ")
    return $vals
end

def clear
    $vals = []
    _save_recorder("clear ")
    return $vals
end

def show
    return $recorder[0..-2] + " = #{$vals.join(' ')}"
end

# 打ち込んだ文字列を逆ポーランド記法と解釈し、一気に演算する関数RPN

$methods = {
    "add" => method(:add),
    "+" => method(:add),
    "sub" => method(:sub),
    "-" => method(:sub),
    "mul" => method(:mul),
    "*" => method(:mul),
    "×" => method(:mul),
    "x" => method(:mul),
    "div" => method(:div),
    "/" => method(:div),
    "÷" => method(:div),
    "mod" => method(:mod),
    "%" => method(:mod),
    "inv" => method(:inv),
    "exch" => method(:exch)
}

def _RPN(str)
    clear()
    fml = str.split
    for tkn in fml
        # if tkn == "e" then next end
        if tkn =~ /-?[1-9]*\d+\.?\d*/
            e Float(tkn)
        elsif $methods.include? tkn
            $methods[tkn].call
        end
    end
    res = $vals.length == 1 ? $vals[0] : $vals
    clear()
    $recorder = ""
    return res
end

def rpn
    print("RPN formula ? ")
    _RPN(STDIN.gets.gsub("\n", ""))
end