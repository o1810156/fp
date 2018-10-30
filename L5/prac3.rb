load "pict.rb"
PATH = "prac3_pics/"

class Image
    def fill(center=[0, 0], color=Pixel.new(0, 0, 0), &f)
        @height.times do |y|
            @width.times do |x|
                if yield(x-center[0], y-center[1]) then pset(x, y, color.r, color.g, color.b) end
            end
        end
    end
end

# ==== fill_OO ====

def fill_circle(img, x0, y0, rad, r, g, b)
    img.fill([x0, y0], color=Pixel.new(r, g, b)) { |x, y|
        x**2 + y**2 <= rad**2
    }
end

# a

def fill_donut(img, x0, y0, in_rad, ex_rad, r, g, b)
    img.fill([x0, y0], color=Pixel.new(r, g, b)) { |x, y|
        x**2 + y**2 <= ex_rad**2 and x**2 + y**2 > in_rad**2
    }
end

img_a = Image.new(200, 200)
fill_donut(img_a, 100, 100, 25, 50, 115, 66, 41)
img_a.write2ppm(PATH+"p_a.ppm")

# b
# 長方形

def fill_rect(img, x_s, y_s, x_g, y_g, r, g, b)
    img.fill([0, 0], color=Pixel.new(r, g, b)) { |x, y|
        x_s <= x and x <= x_g and y_s <= y and y <= y_g
    }
end

img_b_rect = Image.new(300, 200)
fill_rect(img_b_rect, 50, 50, 250, 150, 0, 0, 255)
img_b_rect.write2ppm(PATH+"p_b_rect.ppm")

# b
# 楕円

def fill_ellipse(img, x0, y0, xr, yr, r, g, b)
    img.fill([x0, y0], color=Pixel.new(r, g, b)) { |x, y|
        (x**2 / (xr**2).to_f) + (y**2 / (yr**2).to_f) <= 1
    }
end

img_b_ellipse = Image.new(300, 200)
fill_ellipse(img_b_ellipse, 150, 100, 100, 50, 255, 0, 0)
img_b_ellipse.write2ppm(PATH+"p_b_ellipse.ppm")

# c 三角形
# ある意味で演習1のリファクタリングである。

def fill_triangle(img, p1, p2, p3, r, g, b)
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
    img.fill([p1[0], p1[1]], color=Pixel.new(r, g, b)) { |x, y|
        t = rev[0][0]*x + rev[0][1]*y
        u = rev[1][0]*x + rev[1][1]*y
        t >= 0 and u >= 0 and t + u <= 1
    }
end

img_c = Image.new(300, 200)
fill_triangle(img_c, [100, 50], [50, 100], [200, 150], 255, 255, 0)
img_c.write2ppm(PATH+"p_c.ppm")

# d 正n角形
# 三角形に分割すれば塗ることができることを利用する。

def fill_reg_polygon(img, n, center, p0, r, g, b)
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
        fill_triangle(img, ps[0], ps[i+1], ps[i+2], r, g, b)
    end
end

# ==== ####### ====

img_d = Image.new(3000, 2000)
fill_reg_polygon(img_d, 8, [1500, 1000], [1500-500/(Math::tan((3/8.0)*Math::PI)), 500], 255, 165, 0)
img_d.write2ppm(PATH+"p_d.ppm")