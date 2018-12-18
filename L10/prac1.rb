Cell = Struct.new(:data, :next)

# 後ろから定義して最初のポインタを最後に返す関数。とても巧妙
def atol(a)
    ptr = nil
	(a.length-1).step(0, -1) do |i|
		ptr = Cell.new(a[i], ptr)
	end
	return ptr
end

list_A = atol([0, 1, 2, 3])

def atol_rec(a, pos = 0)
    if a.length <= pos
        return nil
    else
        return Cell.new(a[pos], atol_rec(a, pos+1))
    end
end

list_B = atol_rec(["A", "B", "C", "D"])

def listlen(ptr)
    len = 0
    while ptr != nil
        ptr = ptr.next
        len += 1
    end
    return len
end

p listlen(list_A) # => 4

def listlen_rec(ptr)
    if ptr == nil
        return 0
    else
        return listlen_rec(ptr.next) + 1
    end
end

p listlen_rec(list_B) # => 4

def printlist(ptr)
    while ptr != nil
        puts ptr.data
        # print("#{ptr.data}, ")
        ptr = ptr.next
    end
    puts
end

printlist(list_A)
# =>
# 0
# 1
# 2
# 3

def printlist_rec(ptr)
    if ptr != nil
        puts ptr.data
        printlist_rec(ptr.next)
    end
end

printlist_rec(list_B)
# =>
# A
# B
# C
# D

def revprintlist_rec(ptr)
    if ptr != nil
        revprintlist_rec(ptr.next)
        puts ptr.data
    end
end

revprintlist_rec(list_B)
# =>
# D
# C
# B
# A

# 演習1

# a 合計値を求める

def listsum(ptr)
    if ptr != nil
        return ptr.data + listsum(ptr.next)
    else
		return 0
    end
end

p listsum(list_A) # => 6

# b 文字列連結

def listcat(ptr)
    if ptr != nil
        return ptr.data.to_s + listcat(ptr.next)
    else
		return ""
    end
end

p listcat(list_B) # => "ABCD"

# c bの逆順

def listcatrev(ptr)
    if ptr != nil
        return listcatrev(ptr.next) + ptr.data.to_s
    else
		return ""
    end
end

p listcatrev(list_B) # => "DCBA"

# d 行ごとに倍に表示

def printmany(ptr, i=1)
    if ptr != nil
        puts ptr.data.to_s * i
        printmany(ptr.next, i*2)
    end
end

printmany(list_B)

# =>
# A
# BB
# CCCC
# DDDDDDDD

# e 奇数番目だけ合計する

# list_C = atol(Array.new(10) do |i| i+1 end) # => 1..10
list_C = atol(Array(1..10))

# 次の次をたどる

def listoddsum(ptr)
    if ptr != nil && ptr.next != nil
        # puts "+#{ptr.data}"
        return ptr.data + listoddsum(ptr.next.next)
    else
		return 0
    end
end

# 1 + 3 + 5 + 7 + 9
p listoddsum(list_C) # => 25

# 相互再帰

def listoddsum_odd(ptr)
    if ptr != nil
        # puts "+#{ptr.data}"
        return ptr.data + listoddsum_eve(ptr.next)
    else
        return 0
    end
end

def listoddsum_eve(ptr)
    if ptr != nil
        return listoddsum_odd(ptr.next)
    else
        return 0
    end
end

p listoddsum_odd(list_C) # => 25

# f 逆順の単リストを返す

def listrev(ptr)
    res = nil
    while ptr != nil
        res = Cell.new(ptr.data, res)
        ptr = ptr.next
    end
    return res
end

list_C_rev = listrev(list_C)
# printlist(list_C)
printlist(list_C_rev)
# =>
# 10
# 9
# 8
# 7
# 6
# 5
# 4
# 3
# 2
# 1