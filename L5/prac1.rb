load "pict.rb"
PATH="prac1_pics/"

img1 = Image.new(300, 200)
img1.pset(100, 80, 255, 0, 0)
img1.write2ppm(PATH+"p1.ppm")

img2 = Image.new(300, 200)
80.step(119) do |x|
    img2.pset(x, 80, 0, 0, 255)
end
img2.write2ppm(PATH+"p2.ppm")

# a 斜め
img_a = Image.new(200, 200)
for x in 0..199
    img_a.pset(x, x, 0, 255, 0)
end
img_a.write2ppm(PATH+"p_a.ppm")

img_a2 = Image.new(200, 200)
for x in 0..199
    img_a2.pset(x, 199-x, 0, 255, 0)
end
img_a2.write2ppm(PATH+"p_a2.ppm")

# b 幅nの線を引く
def line_n(n)
    img = Image.new(300, 200)
    80.step(119) do |x|
        for y in (80-n/2)..(80+(n+1)/2)-1
            img.pset(x, y, 255, 255, 0)
        end
    end
    img.write2ppm(PATH+"p_b_line_#{n}.ppm")
end

line_n(2)
line_n(3)
line_n(4)
line_n(5)

# c 長方形や正方形を描く
img_c = Image.new(300, 200)
130.step(169) do |x|
    img_c.pset(x, 80, 255, 0, 0)
    img_c.pset(x, 119, 255, 0, 0)
end
80.step(119) do |y|
    img_c.pset(130, y, 255, 0, 0)
    img_c.pset(169, y, 255, 0, 0)
end
img_c.write2ppm(PATH+"p_c.ppm")

# d cについて中を塗りつぶす
img_d = Image.new(300, 200)
130.step(169) do |x|
    80.step(119) do |y|
        img_d.pset(x, y, 0, 255, 0)
    end
end
img_d.write2ppm(PATH+"p_d.ppm")

# e
def triangle_img(p_a, p_b, p_c, fill=false, color=Pixel.new(0, 0, 0))
    if color.class != Pixel then raise ArgumentError.new "color must be Pixel." end
    [p_a, p_b, p_c].each do |p|
        if (p.class != Array or p.length != 2 or
                p[0] < 0 or 300 <= p[0]
                p[1] < 0 or 200 <= p[1]) then
            return
        end
    end
    img = Image.new(300, 200)
    ab_coef = (p_a[1] - p_b[1]) / (p_a[0] - p_b[0]).to_f
    ab = {
        :line => lambda {|x| ab_coef*(x - p_a[0]) + p_a[1]},
        :range => [p_a[0], p_b[0]]
    }

    bc_coef = (p_b[1] - p_c[1]) / (p_b[0] - p_c[0]).to_f
    bc = {
        :line => lambda {|x| bc_coef*(x - p_b[0]) + p_b[1]},
        :range => [p_b[0], p_c[0]]
    }

    ca_coef = (p_c[1] - p_a[1]) / (p_c[0] - p_a[0]).to_f
    ca = {
        :line => lambda {|x| ca_coef*(x - p_c[0]) + p_c[1]},
        :range => [p_c[0], p_a[0]]
    }

    if fill
        x_center = (p_a[0]+p_b[0]+p_c[0]) / 3.0
        y_center = (p_a[1]+p_b[1]+p_c[1]) / 3.0
        field = Array.new(img.height) do
            Array.new(img.width, 0)
        end
        [ab, bc, ca].each do |pp|
            t = pp[:line].call(x_center) < y_center ? 1 : -1

            h_x, l_x = pp[:range][0] > pp[:range][1] ? [pp[:range][0], pp[:range][1]] : [pp[:range][1], pp[:range][0]]
            l_x.step(h_x) do |x|
                l_y = pp[:line].call(x).to_i
                l_y = l_y < 0 ? 0 : l_y >= img.height ? img.height : l_y
                l_y.times do |y|
                    # puts "(#{x}, #{y})"
                    field[y][x] -= t
                end
                l_y.step(img.height-1) do |y|
                    # puts "(#{x}, #{y})"
                    field[y][x] += t
                end
            end
        end
        field.each_with_index do |a, y|
            a.each_with_index do |b, x|
                if b >= 2 then img.pset(x, y, color.r, color.g, color.b) end
            end
        end
    end
    [ab, bc, ca].each do |pp|
        h_x, l_x = pp[:range][0] > pp[:range][1] ? [pp[:range][0], pp[:range][1]] : [pp[:range][1], pp[:range][0]]
        l_x.step(h_x) do |x|
            img.pset(x, pp[:line].call(x).to_i, color.r, color.g, color.b)
        end
    end

    img.write2ppm(PATH+"p_e_#{p_a[0]}-#{p_a[1]}_#{p_b[0]}-#{p_b[1]}_#{p_c[0]}-#{p_c[1]}.ppm")
end

# とりあえず0割り除算等は考慮しない
triangle_img([100, 50], [50, 100], [200, 150], fill=true, color=Pixel.new(255, 255, 0))
triangle_img([30, 150], [150, 20], [234, 111], fill=false, color=Pixel.new(0, 0, 255))
triangle_img([50, 50], [100, 100], [200, 199], fill=false, color=Pixel.new(0, 255, 0))

# f eをポリゴンに対応させてみた。傾きが∞になる線分にも対応させた
def polygon_img(ps, fill=false, color=Pixel.new(0, 0, 0), name="poly")
    if color.class != Pixel then raise ArgumentError.new "color must be Pixel." end
    if ps.class != Array then raise ArgumentError.new "ps must be Array." end
    ps.each do |p|
        if (p.class != Array or p.length != 2 or
                p[0] < 0 or 300 <= p[0]
                p[1] < 0 or 200 <= p[1]) then
            raise ArgumentError.new "ps must have 2 length Array."
        end
    end
    img = Image.new(300, 200)

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
                if b >= 2 then img.pset(x, y, color.r, color.g, color.b) end
            end
        end
    end
    pps.each do |pp|
        if pp[:line].call(10) != "Infinity"
            pp[:range][0].step(pp[:range][1]) do |x|
                img.pset(x, pp[:line].call(x).to_i, color.r, color.g, color.b)
            end
        else
            pp[:range][0][0].step(pp[:range][0][1]) do |y|
                img.pset(pp[:range][1], y, color.r, color.g, color.b)
            end
        end
    end

    img.write2ppm(PATH+"p_f_#{name}.ppm")
end

polygon_img([[150, 50] \
            ,[(150-50*(Math::sqrt(3)/(2.to_f))).to_i, 75] \
            ,[(150-50*(Math::sqrt(3)/(2.to_f))).to_i, 125] \
            ,[150, 150] \
            ,[(150+50*(Math::sqrt(3)/(2.to_f))).to_i, 125] \
            ,[(150+50*(Math::sqrt(3)/(2.to_f))).to_i, 75] \
        ], fill=true, color=Pixel.new(0, 255, 255), name="hexagon")

def rotate(p0, center, theta)
    pos = [0, 1].map do |i| p0[i] - center[i] end
    return [Math::cos(theta)*pos[0]-Math::sin(theta)*pos[1]+center[0],
            Math::sin(theta)*pos[0]+Math::cos(theta)*pos[1]+center[1]]
end

pentagon = []
p0 = [150, 50]
center = [150, 100]
pentagon.push(p0)
for i in 1..4
    x, y = rotate(p0, center, (2*Math::PI*i)/5.0).map do |t| t.to_i end
    pentagon.push([x, y])
end

points = [0, 2, 4, 1, 3].map do |i| pentagon[i] end
# points = pentagon
polygon_img(points, fill=true, color=Pixel.new(255, 255, 0), name="star")