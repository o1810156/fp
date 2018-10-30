$vals = []
$recorder = ""

def _save_recorder(v)
    $recorder += v
end

def e(x)
    $vals.push(x)
    _save_recorder("#{x} ")
    return $vals
end

def add
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] + x[i][j]
	end end
    $vals.push(z)
    _save_recorder("add ")
    return $vals
end

def sub
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] - x[i][j]
	end end
    $vals.push(z)
    _save_recorder("sub ")
    return $vals
end

def mul
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] * x[i][j]
	end end
    $vals.push(z)
    _save_recorder("mul ")
    return $vals
end

# 行列積

def dot
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		d = 0
		for k in 0..1
			d += y[i][k] * x[k][j]
		end
		z[i][j] = d
	end end
	$vals.push(z)
	_save_recorder("dot ")
	return $vals
end

def div
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] / x[i][j].to_f
	end end
    $vals.push(z)
    _save_recorder("div ")
    return $vals
end

def mod
	x = $vals.pop
	y = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = y[i][j] % x[i][j]
	end end
    $vals.push(z)
    _save_recorder("mod ")
    return $vals
end

def inv
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
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

def clear
    $vals = []
    _save_recorder("clear ")
    return $vals
end

def show
    return $recorder[0..-2] + " = #{$vals.join(' ')}"
end

# b 転置行列
# i行j列とj行i列で対応させるだけである。

def T
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	for i in 0..1 do for j in 0..1 do
		z[i][j] = x[j][i]
	end end
	$vals.push(z)
	_save_recorder("T ")
	return $vals
end

# b 逆行列
# A = [[a, b], [c, d]]
# A^(-1) = ( 1/(ad-bc) ) * [[d, -b], [-c, a]]

def rev
	x = $vals.pop
	z = [[0, 0], [0, 0]]
	m = x[0][0]*x[1][1] - x[0][1]*x[1][0]
	if m == 0
		$vals.push(x) 
		return $vals
	end
	[1, 0].each_with_index do |xi, zi|
		[1, 0].each_with_index do |xj, zj|
			z[zi][zj] = (-1)**(xi+xj) * x[xj][xi] / m.to_f
		end
	end
	$vals.push(z)
	_save_recorder("rev ")
	return $vals
end