load "pict.rb"
PATH = "prac2_pics/"

# fill_circleよりも拡張性が高いfill関数を実装してしまうことにする。
class Image
    def fill(center=[0, 0], color=Pixel.new(0, 0, 0), &f)
        @height.times do |y|
            @width.times do |x|
                if yield(x-center[0], y-center[1]) then pset(x, y, color.r, color.g, color.b) end
            end
        end
    end
end

def fill_circle(img, x0, y0, rad, r, g, b)
    img.fill([x0, y0], color=Pixel.new(r, g, b)) { |x, y|
        x**2 + y**2 <= rad**2
    }
end

img_exCircle = Image.new(300, 200)
fill_circle(img_exCircle, 110, 100, 60, 255, 0, 0)
fill_circle(img_exCircle, 180, 120, 40, 100, 200, 80)
img_exCircle.write2ppm(PATH+"exCircle.ppm")

# a

img_a = Image.new(200, 200)
fill_circle(img_a, 100, 100, 60, 255, 0, 0)
fill_circle(img_a, 100, 100, 40, 0, 255, 0)
fill_circle(img_a, 100, 100, 20, 0, 0, 255)
img_a.write2ppm(PATH+"p_a.ppm")

# b

img_b = Image.new(200, 200)
[-25, 25].each do |dy|
    [-25, 25].each do |dx|
        fill_circle(img_b, 100+dx, 100+dy, 25, 0, 0, 255)
    end
end
img_b.write2ppm(PATH+"p_b.ppm")

# c

img_c = Image.new(200, 200)
[25, 75, 125, 175].each do |x|
    fill_circle(img_c, x, x, 25, 0, 0, 255)
end
img_c.write2ppm(PATH+"p_c.ppm")

img_d = Image.new(300, 200)
p = 0
[50, 40, 30, 20, 10].each do |r|
    p += r
    fill_circle(img_d, p, 100, r, 255, 0, 255)
    p += r
end
img_d.write2ppm(PATH+"p_d.ppm")