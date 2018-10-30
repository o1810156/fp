$vals = []
$recorder = ""
$n = 2

def config(n) # n×n行列に変更
    $n = n
end

def _save_recorder(v)
    $recorder += v
end

def e(x)
    $vals.push(x)
    _save_recorder("#{x} ")
    return $vals
end

$methods = {
    add: lambda {|a, b| a + b},
    sub: lambda {|a, b| a - b},
    mul: lambda {|a, b| a * b},
    div: lambda {|a, b| a / b.to_f},
    mod: lambda {|a, b| a % b},
}

def _eval(meth)
	x = $vals.pop
	y = $vals.pop
	z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		z[i][j] = $methods[meth].call(y[i][j], x[i][j])
	end end
    $vals.push(z)
    _save_recorder("#{meth} ")
    return $vals
end

def add
    _eval(:add)
end

def sub
    _eval(:sub)
end

def mul
    _eval(:mul)
end

def div
    _eval(:div)
end

def mod
    _eval(:mod)
end

def dot
	x = $vals.pop
	y = $vals.pop
	z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		d = 0
		for k in 0..($n-1)
			d += y[i][k] * x[k][j]
		end
		z[i][j] = d
	end end
	$vals.push(z)
	_save_recorder("dot ")
	return $vals
end

def inv
	x = $vals.pop
    z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		z[i][j] = -x[i][j]
	end end
    $vals.push(z)
    _save_recorder("inv ")
    return $vals
end

def exch
    x, y = $vals.pop, $vals.pop
    $vals.push(y); $vals.push(x)
    _save_recorder("exch ")
    return $vals
end

def T
	x = $vals.pop
	z = Array.new($n) {
        Array.new($n, 0)
    }
	for i in 0..($n-1) do for j in 0..($n-1) do
		z[i][j] = x[j][i]
	end end
	$vals.push(z)
	_save_recorder("T ")
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

print("次元 ? ")
$n = Integer(STDIN.gets)