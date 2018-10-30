load "prac4.rb"
PATH = "prac5_pics/"

img_kn = Image_alpha.new(400, 400)
fill_circle(img_kn, 200, 90, 80, lambda {|x, y| Pixel.new(0, 0, 0)})
fill_circle(img_kn, 200, 90, 65, lambda {|x, y| Pixel.new(255, 255, 255)})
fill_rect(img_kn, 193, 170, 207, 313, lambda {|x, y| Pixel.new(0, 0, 0)})
fill_rect(img_kn, 129, 229, 271, 242, lambda {|x, y| Pixel.new(0, 0, 0)})
fill_triangle(img_kn, [192, 305], [124, 373], [133, 380], lambda {|x, y| Pixel.new(0, 0, 0)})
fill_triangle(img_kn, [192, 305], [201, 314], [133, 380], lambda {|x, y| Pixel.new(0, 0, 0)})
fill_triangle(img_kn, [208, 305], [276, 373], [267, 380], lambda {|x, y| Pixel.new(0, 0, 0)})
fill_triangle(img_kn, [208, 305], [199, 314], [267, 380], lambda {|x, y| Pixel.new(0, 0, 0)})
# img_kn.write2ppm(PATH+"kn.ppm")

img1 = Image_alpha.new(3000, 2000)
fill_reg_polygon(img1, 8, [1500, 1000], [1500-250/(Math::tan((3/8.0)*Math::PI)), 750], lambda {|x, y|
    t = ((x-1500)**2 + (y-1000)**2)**3 / 250.0**6
    t = t < 1 ? t : 1
    Pixel_alpha.new(255, 165, 0, t)
})
# img1.ride!(img_kn, 1300, 800)
# img.write2ppm(PATH+"kn_field1.ppm")

img2 = Image_alpha.new(3000, 2000)
fill_reg_polygon(img2, 8, [1500, 1000], [1500-500/(Math::tan((3/8.0)*Math::PI)), 500], lambda {|x, y|
    t = ((x-1500)**2 + (y-1000)**2)**3 / 500.0**6
    t = t < 1 ? t : 1
    Pixel_alpha.new(255, 165, 0, t)
})

img3 = Image_alpha.new(3000, 2000)
fill_reg_polygon(img3, 8, [1500, 1000], [1500-750/(Math::tan((3/8.0)*Math::PI)), 250], lambda {|x, y|
    t = ((x-1500)**2 + (y-1000)**2)**3 / 750.0**6
    # puts "img3 t: #{t}"
    t = t < 1 ? t : 1
    Pixel_alpha.new(255, 165, 0, t)
})
# img3.write2ppm(PATH+"img3.ppm")

# img4 = Image_alpha.new(3000, 2000)
# fill_reg_polygon(img4, 8, [1500, 1000], [1500-875/(Math::tan((3/8.0)*Math::PI)), 125], lambda {|x, y|
#     t = ((x-1500)**2 + (y-1000)**2)**3 / 875.0**6
#     # puts "img4 t: #{t}"  
#     t = t < 1 ? t : 1
#     Pixel_alpha.new(255, 165, 0, t)
# })
# # img4.write2ppm(PATH+"img4.ppm")

img5 = Image_alpha.new(3000, 2000)
1000.times do
    _x = rand(1400..1600)
    if _x == 1500 then next end
    pos = [_x, rand(900..1100)]
    a = (1000-pos[1]) / (1500-pos[0]).to_f
    f = lambda {|x| a * (x - 1500) + 1000}
    3000.times do |x|
        y = f.call(x)
        if 0 <= y and y < 2000
            # img4.pset(x, y, 0, 0, 0, 1)
            # t = ((x-1500)**2 + (y-1000)**2)**3 / 947.0**6
            # t = t < 1 ? t : 0
            img5.pset(x, y, 255, 255, 255, 1)
        end
    end
end
img5.ride!(img_kn, 1300, 800)

# img4.write2ppm(PATH+"line.ppm")
img = img3 + (img2 + (img1 + img5))
img.write2ppm(PATH+"kn_field.ppm")