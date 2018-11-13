load "pict_alpha.rb"
include Math

$theta = PI/2.0 - atan(2/3.0)

img = Image_alpha.new(3000, 2000)
for i in 1..10
    coef = 0.01*i
    img.fill_ff_alpha(center=[1500, 1000], math_pos=true) {|x, y|
        vx, vy = rotate([x, y], [1250, 750], $theta)
        if vy < -coef*(vx - 1250)**2 + 750
            next Pixel_alpha.new(0, 255, 255, coef)
        else
            next Pixel_alpha.new(255, 255, 255, 0)
        end
    }
end
# img.write2ppm("pics/parabola.ppm")

rainbow_colors = [
    # [255, 0, 0],
    # [255, 165, 0],
    # [255, 255, 0],
    [0, 128, 0],
    [0, 255, 255],
    [0, 0, 255],
    [128, 0, 128],
]

srand(1234)

50.times do |i|
    puts "#{i} times"
    set_x = Random.rand(0..2999)
    set_y = Random.rand(0..1999)
    size = sqrt((set_x-2750)**2 + (set_y-250)**2)/3.6
    star_img = Image_alpha.new(size, size)
    pentagon = []
    x0 = Random.rand(size/3..(2*size/3))
    p0 = [x0, sqrt((size/3)**2-(x0-size/2)**2).to_i]
    if p0[0] < 0 or size <= p0[0] or p0[1] < 0 or size <= p0[1]
        p0 = [size/2, size/4]
    end
    center = [size/2, size/2]
    pentagon.push(p0)
    for i in 1..4
        x, y = rotate(p0, center, (2*Math::PI*i)/5.0).map do |t| t.to_i end
        pentagon.push([x, y])
    end
    points = [0, 2, 4, 1, 3].map do |i| pentagon[i] end
    # polygon(star_img, points, true, Pixel_alpha.new(*rainbow_colors[Random.rand(0..6)], Random.rand(0.5..1.0)), :pset_alpha)
    polygon(star_img, points, true, Pixel_alpha.new(*rainbow_colors[Random.rand(0..3)], Random.rand(0.5..1.0)), :pset_alpha)
    img.ride!(star_img, set_x, set_y)
end

img.write2ppm("pics/masterspark.ppm")