# "pict.rb"を根本的に改良し、alphaチャンネルに対応させた
load "pict.rb"

Pixel_alpha = Struct.new(:r, :g, :b, :alpha)

class Image
    def draw_alpha_layer(layer)
        if @width != layer.width or @height != layer.height then raise ArgumentError.new "サイズが合いません。" end
        if layer.class != Image_alpha then raise ArgumentError.new "layer must be Image_alpha." end

        base = Image_alpha.new(@width, @height)
        base.canvas = base.canvas.map {|row|
            row.map {|c|
                Pixel_alpha.new(255, 255, 255, 1)
            }
        }
        layer = base + layer

        layer.canvas.map.with_index do |row, y|
            row.map.with_index do |pix, x|
                # @canvas[y][x] = Pixel.new(*([pix.r, pix.g, pix.b].map {|c| (c*(1 - pix.alpha)).to_i}))
                @canvas[y][x] = Pixel.new(pix.r, pix.g, pix.b)
            end
        end
    end
end

class Image_alpha
    def initialize(width, height)
        @width = width
        @height = height
        @canvas = Array.new(height) do
            Array.new(width) do
                Pixel_alpha.new(255, 255, 255, 0)
            end
        end
    end

    attr_accessor :width, :height, :canvas

    def pset(x, y, r, g, b, alpha=1)
        if !(0 <= x and x < @width and 0 <= y and y < @height)
            puts "[#{x}, #{y}] is out of range."
            raise ArgumentError.new "Please pass arguments having proper range."
        end
        if alpha < 0 or 1 < alpha
            puts "alpha: #{alpha}"
            raise ArgumentError.new "Please pass proper alpha channel [0, 1]."
        end

        @canvas[y][x] = Pixel_alpha.new(r, g, b, alpha)
    end

	# 第6回 追加 ==

	def pset_alpha(x, y, r, g, b, alpha=1)
        if !(0 <= x and x < @width and 0 <= y and y < @height)
            puts "[#{x}, #{y}] is out of range."
            raise ArgumentError.new "Please pass arguments having proper range."
        end
        if alpha < 0 or 1 < alpha
            puts "alpha: #{alpha}"
            raise ArgumentError.new "Please pass proper alpha channel [0, 1]."
        end

		other = Pixel_alpha.new(r, g, b, alpha)
		new_alpha = alpha + @canvas[y][x].alpha * (1- alpha)
        rgb = [:r, :g, :b].map {|col|
            res = new_alpha != 0 ? (other[col] * other.alpha + @canvas[y][x][col] * @canvas[y][x].alpha * (1 - other.alpha))/new_alpha : 0
            res.to_i
        }
		@canvas[y][x] = Pixel_alpha.new(*rgb, new_alpha)
	end

	# ***** **** ==

    # 演習 4 e 美しい絵を描くのにあると良い機能 : Layer機能

    # [wikipedia](https://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%AB%E3%83%95%E3%82%A1%E3%83%96%E3%83%AC%E3%83%B3%E3%83%89)によると
    
    # out_A = src_A + dst_A * (1 - src_A)
    # out_rgb = out_A != 0 ? (src_rgb * src_A + dst_rgb * dst_A * (1 - src_A)) / out_A : 0

    # という計算式でαブレンドができる。

    def blend(other)
        if @width != other.width or @height != other.height then raise ArgumentError.new "サイズが合いません。" end

        o = other.canvas # src
        c = @canvas # dst

        canvas = c.map.with_index {|row, y|
            row.map.with_index {|pix, x|
                alpha = o[y][x].alpha + pix.alpha * (1 - o[y][x].alpha)
                rgb = [:r, :g, :b].map {|col|
                    res = alpha != 0 ? (o[y][x][col] * o[y][x].alpha + pix[col] * pix.alpha * (1 - o[y][x].alpha))/alpha : 0
                    res.to_i
                }
                Pixel_alpha.new(*rgb, alpha)
            }
        }
        tmp = Image_alpha.new(@width, @height)
        tmp.canvas = canvas
        return tmp
    end

    def +(other)
        return blend(other)
    end

    def ride!(other, bx, by)
        o = other.canvas # src
        c = @canvas # dst

        o.each_with_index {|row, y|
            y += by
            if y >= @height then next end
            row.each_with_index {|pix, x|
                x += bx
                if x >= @width then next end
                alpha = pix.alpha + c[y][x].alpha * (1 - pix.alpha)
                rgb = [:r, :g, :b].map {|col|
                    res = alpha != 0 ? (pix[col] * pix.alpha + c[y][x][col] * c[y][x].alpha * (1 - pix.alpha))/alpha : 0
                    res.to_i
                }
                c[y][x] = Pixel_alpha.new(*rgb, alpha)
            }
        }
    end

    def write2ppm(name)
        img = Image.new(@width, @height)
        img.draw_alpha_layer(self)
        img.write2ppm(name)
    end

    def fill(center=[@width/2, @height/2], filter=lambda{|x, y| Pixel_alpha.new(0, 0, 0, 1)}, &f) # filterを受け取れるようにした。
        @height.times do |y|
            @width.times do |x|
                if yield(x-center[0], y-center[1])
                    color = filter.call(x, y)
                    if color.class == Pixel_alpha
                        pset(x, y, color.r, color.g, color.b, color.alpha)
                    elsif color.class == Pixel
                        pset(x, y, color.r, color.g, color.b)
                    elsif color.class == Array
                        if color.length == 4
                            pset(x, y, color[0], color[1], color[2], color[3])
                        elsif color.length == 3
                            pset(x, y, color[0], color[1], color[2])
                        end
                    end
                end
            end
        end
    end

    def _fill_ff(center=[@width/2, @height/2], math_pos=false, pset_method=:pset, &f) # 条件式(function)とフィルター(filter)を一体化させたタイプff...後発なので変わった名前になってしまった...
        @height.times do |y|
            @width.times do |x|
                color = yield(x-center[0], y-center[1])
                _y = math_pos ? @height - (y+1) : y
                if color
                    if color.class == Pixel_alpha
                        method(pset_method).call(x, _y, color.r, color.g, color.b, color.alpha)
                    elsif color.class == Pixel
                        method(pset_method).call(x, _y, color.r, color.g, color.b)
                    elsif color.class == Array
                        if color.length == 4
                            method(pset_method).call(x, _y, color[0], color[1], color[2], color[3])
                        elsif color.length == 3
                            method(pset_method).call(x, _y, color[0], color[1], color[2])
                        end
                    end
                end
            end
        end
    end

    def fill_ff(center=[@width/2, @height/2], math_pos=false, &f)
        _fill_ff(center, math_pos, pset_method=:pset, &f)
    end

    def fill_ff_alpha(center=[@width/2, @height/2], math_pos=false, &f)
        _fill_ff(center, math_pos, pset_method=:pset_alpha, &f)
    end
end

# 諸 描画関数群

def fill_circle(img, x0, y0, rad, filter=lambda{|x, y| Pixel.new(0, 0, 0)})
    img.fill([x0, y0], filter) { |x, y|
        x**2 + y**2 <= rad**2
    }
end

def fill_donut(img, x0, y0, in_rad, ex_rad, filter=lambda{|x, y| Pixel.new(0, 0, 0)})
    img.fill([x0, y0], filter) { |x, y|
        x**2 + y**2 <= ex_rad**2 and x**2 + y**2 > in_rad**2
    }
end

def fill_rect(img, x_s, y_s, x_g, y_g, filter=lambda{|x, y| Pixel.new(0, 0, 0)})
    img.fill([0, 0], filter) { |x, y|
        x_s <= x and x <= x_g and y_s <= y and y <= y_g
    }
end

def fill_ellipse(img, x0, y0, xr, yr, filter=lambda{|x, y| Pixel.new(0, 0, 0)})
    img.fill([x0, y0], filter) { |x, y|
        (x**2 / (xr**2).to_f) + (y**2 / (yr**2).to_f) <= 1
    }
end

def fill_triangle(img, p1, p2, p3, filter=lambda{|x, y| Pixel.new(0, 0, 0)})
    ps = [p1, p2, p3]
    if ps.any? {|p| p.class != Array or p.length != 2} then raise ArgumentError.new "Points must be 2 length Array." end
    if p1 == p2 or p2 == p3 or p3 == p1 then raise ArgumentError.new "Duplication of points is exist there." end
    # ベクトルで考える。
    v1 = [p2[0] - p1[0], p2[1] - p1[1]]
    v2 = [p3[0] - p1[0], p3[1] - p1[1]]
    deno = (v1[0]*v2[1] - v1[1]*v2[0]).to_f
    if deno == 0 then
        raise ArgumentError.new "deno=0\n指定方法を変えてみて下さい。"
    end
    rev = [[v2[1]/deno, -v2[0]/deno], [-v1[1]/deno, v1[0]/deno]]
    img.fill([p1[0], p1[1]], filter) { |x, y|
        t = rev[0][0]*x + rev[0][1]*y
        u = rev[1][0]*x + rev[1][1]*y
        t >= 0 and u >= 0 and t + u <= 1
    }
end

def fill_reg_polygon(img, n, center, p0, filter=lambda{|x, y| Pixel.new(0, 0, 0)})
    if center.class != Array or center.length != 2 then return end
    if p0.class != Array or p0.length != 2 then return end

    theta = (2*Math::PI)/(n.to_f)
    tmp_p = p0
    ps = Array.new(n-1) {
        pos = Array.new(2) {|i| tmp_p[i]-center[i]}
        tmp_p = [Math::cos(theta)*pos[0]-Math::sin(theta)*pos[1]+center[0],
                 Math::sin(theta)*pos[0]+Math::cos(theta)*pos[1]+center[1]]
        [tmp_p[0].to_i, tmp_p[1].to_i]
    }
    ps.insert(0, [p0[0].to_i, p0[1].to_i])
    (n-2).times do |i|
        fill_triangle(img, ps[0], ps[i+1], ps[i+2], filter)
    end
end

# 第6回 追加分 ここから

def rotate(p0, center, theta) # 点pointを、centerを中心にthetaラジアン回転させる
    pos = [0, 1].map do |i| p0[i] - center[i] end
    return [Math::cos(theta)*pos[0]-Math::sin(theta)*pos[1]+center[0],
            Math::sin(theta)*pos[0]+Math::cos(theta)*pos[1]+center[1]].map do |t| t.to_i end
end

def polygon(img, ps, fill=false, color=Pixel_alpha.new(0, 0, 0, 1), pset_method=:pset)
    if color.class != Pixel_alpha then raise ArgumentError.new "color must be Pixel_alpha." end
    if ps.class != Array then raise ArgumentError.new "ps must be Array." end
    ps.each do |p|
        if (p.class != Array or p.length != 2 or
                p[0] < 0 or img.width <= p[0]
                p[1] < 0 or img.height <= p[1]) then
            puts "#{p[0]}, #{p[1]}"
            raise ArgumentError.new "ps must have 2 length Array."
        end
    end

    pps = Array.new(ps.length) do |i| # pps は point point s の略 eで言う a b のような直線の集合
        j = (i+1) % ps.length
        if ps[i][0] == ps[j][0]
            f = lambda{|x| return "Infinity"}
            r = [ps[i][1] < ps[j][1] ? [ps[i][1], ps[j][1]] : [ps[j][1], ps[i][1]], ps[i][0]]
        else
            coef = (ps[i][1] - ps[j][1]) / (ps[i][0] - ps[j][0]).to_f
            f = lambda {|x| coef*(x - ps[i][0]) + ps[i][1]}
            r = ps[i][0] < ps[j][0] ? [ps[i][0], ps[j][0]] : [ps[j][0], ps[i][0]]
        end
        {
            :line => f,
            :range => r
        }
    end

    if fill
        x_center = (ps.inject(0) {|s, _p| s + _p[0]}) / ps.length.to_f
        y_center = (ps.inject(0) {|s, _p| s + _p[1]}) / ps.length.to_f
        field = Array.new(img.height) do
            Array.new(img.width, 0)
        end
        pps.each do |pp|
            if pp[:line].call(10) != "Infinity"
                t = pp[:line].call(x_center) < y_center ? 1 : -1

                pp[:range][0].step(pp[:range][1]) do |x|
                    l_y = pp[:line].call(x).to_i # l_y <= line y
                    l_y = l_y < 0 ? 0 : l_y >= img.height ? img.height : l_y
                    l_y.times do |y|
                        field[y][x] -= t
                    end
                    l_y.step(img.height-1) do |y|
                        field[y][x] += t
                    end
                end
            else
                l_x = pp[:range][1]
                t = l_x < x_center ? 1 : -1

                pp[:range][0][0].step(pp[:range][0][1]) do |y|
                    l_x.times do |x|
                        field[y][x] -= t
                    end
                    l_x.step(img.width-1) do |x|
                        field[y][x] += t
                    end
                end
            end
        end
        field.each_with_index do |a, y|
            a.each_with_index do |b, x|
                if b >= 2 then img.method(pset_method).call(x, y, color.r, color.g, color.b, color.alpha) end
            end
        end
    end
    pps.each do |pp|
        if pp[:line].call(10) != "Infinity"
            pp[:range][0].step(pp[:range][1]) do |x|
                img.method(pset_method).call(x, pp[:line].call(x).to_i, color.r, color.g, color.b, color.alpha)
            end
        else
            pp[:range][0][0].step(pp[:range][0][1]) do |y|
                img.method(pset_method).call(pp[:range][1], y, color.r, color.g, color.b, color.alpha)
            end
        end
    end
end
