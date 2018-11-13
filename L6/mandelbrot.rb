load "pict_alpha.rb"

# とりあえず動的計画法はなしで(というか多分無理)
# book = Array.new(1000) do Array.new(1000) end

KAIZODO = 500
TIMES = 100
KPER2 = KAIZODO/2
KPER4 = KAIZODO/4.0
TIMES_F = TIMES.to_f

img = Image_alpha.new(KAIZODO, KAIZODO)
img.fill_ff(center=[KPER2, KPER2], math_pos=true) do |x, y|
    z = Complex(0, 0)
    c = Complex(x/KPER4, y/KPER4)
    flag = false
    TIMES.times do |i|
        z = z**2 + c
        if z.abs > 2
            flag = i
            break
        end
    end
    flag ? Pixel_alpha.new(255, 0, 0, flag/TIMES_F) : Pixel.new(0, 0, 0)
end
img.write2ppm("pics/mandelbrot.ppm")