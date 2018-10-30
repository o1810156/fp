$x = 0
$pres = []
$list = []
$pre_lists = []

# b

def _save_pre
    $pres.push($x)
end

def sum(v)
    _save_pre()
    $x += v
    $list.push(v)
    return $x
end

def reset
    _save_pre()
    $x = 0
    $pre_lists.push($list.dup)
    $list = []
    return $x
end

# a

def dec(v)
    _save_pre()
    $x -= v
    $list.push(-v)
    return $x
end

# b

def undo
    $x = $pres.length > 0 ? $pres.pop : 0
    return $x
end

# c

def list_sum
    return $list.sum
end

def list_undo
    $list = $pre_lists.pop
    return $list
end