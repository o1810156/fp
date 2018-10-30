load "prac4.rb"

img = Image_alpha.new(300, 200)
fill_rect(img, 25, 25, 275, 175, lambda {|x, y|
    t = (25 <= x and x <= 275) ? (x-25) / 250.0 : 0
    Pixel_alpha.new(255, 255, 0, t)
})
img.write2ppm(PATH+"p_c_rect.ppm")

img = Image_alpha.new(300, 200)
fill_circle(img, 150, 100, 75, lambda {|x, y|
    t = Math::sqrt((x-150)**2 + (y-100)**2) / 100.0
    t = t < 1 ? t : 1
    Pixel_alpha.new(255, 165, 0, t)
})
img.write2ppm(PATH+"p_c_circle.ppm")