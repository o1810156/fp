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

class Matrix
    def initialize(arr)
        if not arr.is_a? Array or
                not arr[0].is_a? Array or
                arr.any? {|row| row.length != arr[0].length} then
            raise ArgumentError
        end

        @mat = arr
        @row_num = arr.length
        @col_num = arr[0].length
    end

    attr :mat, :row_num, :col_num

    def inspect
        return "[[" + (@mat.map do |r| r = r.map do |v| v.rnd(3) end; r.join(", ") end).join("],\n [") + "]]"
    end

    def to_s
        return @mat.to_s
    end

    def op(o, m)
        if not m.is_a? Matrix then raise ArgumentError, "need Matrix" end
        if m.row_num != @row_num or m.col_num != @col_num then raise ArgumentError, "sizes were not matched:\nrow: #{@row_num} | #{m.row_num}\ncol: #{@col_num} | #{m.col_num}" end
        
        res = m.mat.map.with_index do |r, i|
            r.map.with_index do |v, j|
                @mat[i][j].method(o).call(v)
            end
        end

        return Matrix.new(res)
    end

    def +(m)
        return self.op(:+, m)
    end

    def -(m)
        return self.op(:-, m)
    end

    def *(m)
        if m.is_a? Numeric
            return Matrix.new(@mat.map do |r| r.map do |v| m * v end end)
        else
            return self.op(:*, m)
        end
    end

    def /(m)
        if m.is_a? Numeric
            return Matrix.new(@mat.map do |r| r.map do |v| v / m.to_f end end)
        else
            m = m.mat.map do |row| row.map do |v| v.to_f end end
            return self.op(:/, Matrix.new(m))
        end
    end

    def T # 転置
        res = []
        @col_num.times do |j|
            row = []
            @row_num.times do |i|
                row.push(@mat[i][j])
            end
            res.push(row)
        end
        return Matrix.new(res)
    end

    def echelonize # 簡約化
        res = @mat.dup
        j = 0
        @col_num.times do |j|
            i_ori = j
            i = i_ori
            while i_ori < @row_num
                while i < @row_num
                    k = res[i][j]
                    if k == 0
                        i += 1
                        next
                    end
                    
                    @row_num.times do |i2|
                        if res[i2][j] == 0
                            next
                        elsif i2 == i
                            res[i] = res[i].map do |v| v / k.to_f end
                        else
                            t = res[i2][j] / k.to_f
                            j.step(@col_num-1) do |j2|
                                res[i2][j2] -= res[i][j2] * t
                            end
                        end
                    end
                    res[i_ori], res[i] = res[i], res[i_ori]
                    i += 1
                end
                i_ori += 1
            end
        end
        return Matrix.new(res)
    end

=begin
今回は省略

    def rev # 逆行列
        if @row_num != @col_num then return self end
        res = @mat.dup
        res = res.map.with_index do |row, i|
            a = Array.new(@row_num, 0)
            a[i] = 1
            a.each do |v|
                row.push(v)
            end
            row
        end
        res = Matrix.new(res).echelonize
        res = res.mat.map do |row|
            row[@row_num..(2*@row_num-1)]
        end
        return Matrix.new(res)
    end
=end

    def dot(m) # 行列積
        if @col_num != m.row_num then
            raise ArgumentError, "a.dot(b): a.col_num and b.row_num are must be same.\na.col_num: #{@col_num}\nb.row_num: #{m.row_num}"
        end

        res = []
        @row_num.times do |i|
            row = []
            m.col_num.times do |j|
                v = 0
                @col_num.times do |k|
                    v += @mat[i][k] * m.mat[k][j]
                end
                row.push(v)
            end
            res.push(row)
        end

        return Matrix.new(res)
    end
end

a = Matrix.new([[-1, 1, 0], [3, 0, 4]])
b = Matrix.new([[1, 0], [-2, 1], [3, 2]])
c = Matrix.new([[3], [2], [-1]])

d = Matrix.new([[1, 2, 3], [4, 5, 6]])

puts "## 四則演算"

p a + d
p a - d
p a * d
p a / d

puts "## 転置"

p a.T

puts "## 簡約化"

p a.echelonize

g = Matrix.new(
    [[2, 0, 3, 2],
     [3, 1, 0, 1],
     [0, -2, 9, 4],
     [1, 1, 3, 1]]
)

p g.echelonize

=begin

今回は省略

puts "## 逆行列"

h = Matrix.new(
    [[1, 4],
     [7, 2]]
)

p h.echelonize
p h.rev

q = Matrix.new(
    [[0, 2, -1, 4],
     [1, 3, 1, 0],
     [-1, 1, 0, 2],
     [2, 4, -1, 2]]
)

p q.echelonize
p q.rev

=end

# 行列積

def dot_homework(a, b)
    begin
        puts "#{a}・#{b} = #{a.dot(b)}"
    rescue ArgumentError
        puts "#{a}・#{b} -> 定義されない"
    end
end

ta = a.T
tb = b.T
tc = c.T

p ta
p tb
p tc

mats = [a, b, c, ta, tb, tc]

for m in mats
    for n in mats
        dot_homework(m, n)
    end
end

# 結果は第3回 appendix1と同様なので省略。
# 第3回 appendix1はこちらからご覧いただけます。
# https://github.com/o1810156/fp/blob/master/L3/appendix1.rb