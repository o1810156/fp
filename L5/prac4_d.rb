load "prac4.rb"

img = Image_alpha.new(300, 200)
fill_circle(img, 150, 100, 75, lambda {|x, y|
    t = ((x-150)**2 + (y-100)**2)**3 / 75.0**6
    t = t < 1 ? t : 1
    Pixel_alpha.new(255, 165, 0, t)
})
img.write2ppm(PATH+"p_d_circle.ppm")

img = Image_alpha.new(3000, 2000)
fill_reg_polygon(img, 8, [1500, 1000], [1500-500/(Math::tan((3/8.0)*Math::PI)), 500], lambda {|x, y|
    t = ((x-1500)**2 + (y-1000)**2)**3 / 500.0**6
    t = t < 1 ? t : 1
    Pixel_alpha.new(255, 165, 0, t)
})
img.write2ppm(PATH+"p_d_hexagon.ppm")