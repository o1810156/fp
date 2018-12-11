# a

class Memory
	def initialize
		@mem = nil
	end
	def put(m)
		@mem = m
	end
	def get
		return @mem
	end
end

m1 = Memory.new
p m1.put(5) # => 5
p m1.get # => 5
p m1.get # => 5
p m1.put(10) # => 10
p m1.get # => 10

# b

class Concat
	def initialize(s = "", d = "")
		@mem = s
		@deli = d
	end
	def add(s)
		@mem += @deli + s
	end
	def get
		return @mem
	end
	def reset
		@mem = ""
	end
	def set_deli(d)
		@deli = d
	end
end

c = Concat.new
p c.add("This") # => "This"
p c.add("is") # => "Thisis"
p c.get # => "Thisis"
p c.add("a") # => "Thisisa"
p c.reset # => ""
p c.add("pen") # => "pen"
p c.get # => "pen"

# デリミタを指定してみた

c = Concat.new("This")
c.set_deli(" ")
# c.add("This") # <= デフォルト値として設定させる
c.add("is")
c.add("a")
c.add("pen")
p c.get # => "This is a pen"

# c

class Memory2
	def initialize
		@mem_arr = Array.new
	end
	# def get
	def pop # 忘れるならpopの方がいい
		return @mem_arr.pop # 最大数より多く取り出すとnilになるのでこれでよい
	end
	def put(x)
		if @mem_arr.length >= 2
			@mem_arr[0], @mem_arr[1] = @mem_arr[1], x
		else
			@mem_arr.push(x)
		end
	end
end

m2 = Memory2.new
m2.put("knyssは")
m2.put("FP2018のラスボス")
p m2.pop # => "FP2018のラスボス"
m2.put("天才")
p m2.pop # => "天才"
p m2.pop # => "knyssは"
p m2.pop # => nil

# 2つまでしか覚えられない

m2.put("hoge")
m2.put("fuga")
m2.put("bar")
m2.put("baz")
p m2.pop # => "baz"
p m2.pop # => "bar"
p m2.pop # => nil
p m2.pop # => nil

class MemoryN
	def initialize(n)
		@mem_len = n
		@mem_arr = Array.new
	end
	def pop
		return @mem_arr.pop
	end
	def put(x)
		if @mem_arr.length >= @mem_len
			(@mem_len-1).times do |i|
				@mem_arr[i] = @mem_arr[i+1]
			end
			@mem_arr[@mem_len-1] = x
		else
			@mem_arr.push(x)
		end
	end
end

m3 = MemoryN.new(3)
m3.put("knyssは")
m3.put("FP2018のラスボスで")
m3.put("天才ハカー")
p m3.pop # => "天才ハカー"
m3.put("アイコンが棒人間")
p m3.pop # => "アイコンが棒人間"
p m3.pop # => "FP2018のラスボスで"
p m3.pop # => "knyssは"
p m3.pop # => nil

# 3つまでしか覚えられない

m3.put("hoge")
m3.put("fuga")
m3.put("bar")
m3.put("baz")
p m3.pop # => "baz"
p m3.pop # => "bar"
p m3.pop # => "fuga"
p m3.pop # => nil
