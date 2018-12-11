class Integer
    def rnd(n)
        return self
    end
end

class Float
    def rnd(n)
        return self.round(n)
    end
end

class Comp
	def initialize(r, i)
		@r = r
		@i = i
	end

	def getRe
		return @r
    end

	def getIm
		return @i
    end
    
    def abs
        return Math::sqrt(@r**2 + @i**2)
    end

    def dup
        return Comp.new(@r, @i)
    end

    def to_s
        r_s = @r != 0 ? @r.rnd(3).to_s : ""
        if @i == 0
            i_s = ""
        elsif @i.abs != 1
            i_s = @i > 0 && @r != 0 ? "+" + @i.rnd(3).to_s + "i" : @i.rnd(3).to_s + "i"
        else
            if @i > 0
                i_s = @r != 0 ? "+i" : "i"
            else
                i_s = "-i"
            end
        end
        return r_s + i_s
	end

    def +(c)
        cr = c.getRe
        ci = c.getIm
		return Comp.new(@r+cr, @i+ci)
	end

    def -(c)
        cr = c.getRe
        ci = c.getIm
		return Comp.new(@r-cr, @i-ci)
	end

	def *(c)
        cr = c.getRe
        ci = c.getIm
        t = Comp.new(@r * cr, @r * ci)
        u = Comp.new(-(@i * ci), @i * cr)
        return t + u
	end

	def /(c)
        cr = c.getRe
        ci = c.getIm
        d = ((c.abs)**2).to_f # Denominator 分母
        t = Comp.new(cr, -ci)
        n = self * t # Numerator
        return Comp.new(n.getRe/d.to_f, n.getIm/d.to_f)
	end

    # 通常の実装では以下

    # def **(n)
    #     res = self.dup
    #     if n % 2 == 0
    #         res = self**(n/2) * self**(n/2)
    #     else
    #         res = self * self**(n-1)
    #     end
    #     return res 
    # end

    # 折角なので極方程式を使用する

    def arg
        if @i > 0
            return Math::acos(@r / self.abs.to_f)
        else
            return Math::acos(-@r / self.abs.to_f) + Math::PI
        end
    end

    def **(n)
        r = self.abs ** n
        t = (n*self.arg) % (2*Math::PI)
        return Comp.new(r * Math::cos(t), r * Math::sin(t))
    end
end

def Re(c)
    return c.getRe
end

def Im(c)
    return c.getIm
end

def arg(c)
    return c.arg
end

fomulas = ["a", "b", "c",
"a + b", "a - c", "a * c", "a - c * b",
"a.abs",
"a.arg / Math::PI",
"a**5",
"(c - b) / (a - b)"]

fomulas.each do |f|
    a = Comp.new(-1, -1)
    b = Comp.new(0, 1)
    c = Comp.new(1, -2)
    res = eval(f)
    puts "#{f} = #{res}"
end

# =>
# a = -1-i
# b = i
# c = 1-2i
# a + b = -1
# a - c = -2+i
# a * c = -3+i
# a - c * b = -3-2i
# a.abs = 1.4142135623730951
# a.arg / Math::PI = 1.25
# a**5 = 4.0+4.0i
# (c - b) / (a - b) = 1.0+1.0i

# 複素数を使用すると回転を簡単に記述できる

PI4C = Comp.new(Math::cos(Math::PI/4.0), Math::sin(Math::PI/4.0))
PI8C = Comp.new(Math::cos(Math::PI/8.0), Math::sin(Math::PI/8.0))

# 45°回した場合

sq1 = [[1, 1], [-1, 1], [-1, -1], [1, -1]].map do |pos|
    res = Comp.new(pos[0], pos[1]) * PI4C
    [Re(res).round(3), Im(res).round(3)]
end

p sq1

# 22.5°回した場合

sq2 = [[1, 1], [-1, 1], [-1, -1], [1, -1]].map do |pos|
    res = Comp.new(pos[0], pos[1]) * PI8C
    [Re(res).round(3), Im(res).round(3)]
end

p sq2

# =>
# [[0.0, 1.414], [-1.414, 0.0], [0.0, -1.414], [1.414, 0.0]]
# [[0.541, 1.307], [-1.307, 0.541], [-0.541, -1.307], [1.307, -0.541]]