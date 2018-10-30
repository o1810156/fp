load "pict_alpha.rb"
PATH = "prac4_pics/"

# prac3の関数群を定義しなおす。ここで模様も設定できるようにする。

class Image_alpha
    def fill(center=[0, 0], filter=lambda{|x, y| Pixel_alpha.new(0, 0, 0, 1)}, &f) # filterを受け取れるようにした。
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
end

# 以下演習3の
# ==== fill_OO ====

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
        tmp_p = [Math::cos(theta)*pos[0]-Math::sin(theta)*pos[1]+center[0], Math::cos(theta)*pos[0]+Math::sin(theta)*pos[1]+center[1]]
        [tmp_p[0].to_i, tmp_p[1].to_i]
    }
    ps.insert(0, [p0[0].to_i, p0[1].to_i])
    (n-2).times do |i|
        fill_triangle(img, ps[0], ps[i+1], ps[i+2], filter)
    end
end

# ==== ####### ====
# とほぼ同じ内容なので省略