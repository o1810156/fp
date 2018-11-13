load './pict_alpha.rb'

img = Image_alpha.new(300, 200)
[200, 224, 255].each_with_index do |c, i|
	res = [[100, 50], [200, 50], [200, 150], [100, 150]].map do |point| rotate(point, [150, 100], (Math::PI*i)/8.0) end
	polygon(img, res, fill=true, color=Pixel_alpha.new(c, (c*(165/255.0)).to_i, 0, alpha=0.7), pset_method="pset_alpha")
end
img.write2ppm("pics/reg_rect.ppm")
