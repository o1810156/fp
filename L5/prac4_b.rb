load "prac4.rb"

# b 兼 e
# 主にpict_alpha.rbで定義した機能の確認である。

# img_r = Image_alpha.new(300, 200)
# fill_circle(img_r, 150, 70, 50, lambda {|x, y| Pixel_alpha.new(255, 0, 0, 1)})
# img_g = Image_alpha.new(300, 200)
# fill_circle(img_g, 124, 115, 50, lambda {|x, y| Pixel_alpha.new(0, 225, 0, 1)})
# img_b = Image_alpha.new(300, 200)
# fill_circle(img_b, 176, 115, 50, lambda {|x, y| Pixel_alpha.new(0, 0, 255, 1)})
# (img_r + img_g + img_b).write2ppm(PATH+"p_b_small.ppm")

img_r = Image_alpha.new(3000, 2000)
fill_circle(img_r, 1500, 700, 500, lambda {|x, y| Pixel_alpha.new(255, 0, 0, 0.33)})
img_g = Image_alpha.new(3000, 2000)
fill_circle(img_g, 1240, 1150, 500, lambda {|x, y| Pixel_alpha.new(0, 225, 0, 0.33)})
img_b = Image_alpha.new(3000, 2000)
fill_circle(img_b, 1760, 1150, 500, lambda {|x, y| Pixel_alpha.new(0, 0, 255, 0.33)})
(img_r + img_g + img_b).write2ppm(PATH+"p_b_rgb.ppm")

# img_c = Image_alpha.new(3000, 2000)
# fill_circle(img_c, 1500, 700, 500, lambda {|x, y| Pixel_alpha.new(0, 255, 255, 0.66)})
# img_m = Image_alpha.new(3000, 2000)
# fill_circle(img_m, 1240, 1150, 500, lambda {|x, y| Pixel_alpha.new(255, 0, 255, 0.66)})
# img_y = Image_alpha.new(3000, 2000)
# fill_circle(img_y, 1760, 1150, 500, lambda {|x, y| Pixel_alpha.new(255, 255, 0, 0.66)})
# (img_c + img_m + img_y).write2ppm(PATH+"p_b_cmy.ppm")