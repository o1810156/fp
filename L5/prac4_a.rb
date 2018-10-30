load "prac4.rb"

filters = {
    "stripe" => lambda {|x, y|
        ((x / 5) % 2) == 0 ? Pixel.new(255, 255, 0) : Pixel.new(255, 255, 255)
    },
    "border" => lambda {|x, y|
        ((y / 5) % 2) == 0 ? Pixel.new(0, 255, 255) : Pixel.new(255, 255, 255)
    },
    "check" => lambda {|x, y|
        (((x / 5)+(y / 5)) % 2) == 1 ? Pixel.new(0, 0, 0) : Pixel.new(255, 255, 255)        
    }
}

filters.each {|key, filter|
    img_a = Image_alpha.new(200, 200)
    fill_donut(img_a, 100, 100, 25, 50, filter)
    img_a.write2ppm(PATH+"#{key}/p_a.ppm")

    img_b_rect = Image_alpha.new(300, 200)
    fill_rect(img_b_rect, 50, 50, 250, 150, filter)
    img_b_rect.write2ppm(PATH+"#{key}/p_b_rect.ppm")

    img_b_ellipse = Image_alpha.new(300, 200)
    fill_ellipse(img_b_ellipse, 150, 100, 100, 50, filter)
    img_b_ellipse.write2ppm(PATH+"#{key}/p_b_ellipse.ppm")

    img_c = Image_alpha.new(300, 200)
    fill_triangle(img_c, [100, 50], [50, 100], [200, 150], filter)
    img_c.write2ppm(PATH+"#{key}/p_c.ppm")

    img_d = Image_alpha.new(3000, 2000)
    fill_reg_polygon(img_d, 8, [1500, 1000], [1500-500/(Math::tan((3/8.0)*Math::PI)), 500], filter)
    img_d.write2ppm(PATH+"#{key}/p_d.ppm")
}