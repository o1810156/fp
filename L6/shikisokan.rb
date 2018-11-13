load "pict_alpha.rb"
include Math
SDR = Math::PI/3.0 # Sixty Degree Radian

def pos2rad(x, y)
    if x == 0
        return y > 0 ? PI/2.0 : PI*3/2.0
    end
    t = y/(x.to_f)
    if x > 0
        rad = t >= 0 ? atan(t) : atan(t)+2*PI
    else
        rad = atan(t)+PI
    end
    return rad
end

COEF = 255/(PI/3.0)
def c_func(rad)
    (COEF * rad).to_i
end

red_val_f = [
    lambda {|rad| 255},
    lambda {|rad| rad -= SDR; 255-c_func(rad)},
    lambda {|rad| 0},
    lambda {|rad| 0},
    lambda {|rad| rad -= SDR*4; c_func(rad)},
    lambda {|rad| 255}
]
green_val_f = [
    lambda {|rad| c_func(rad)},
    lambda {|rad| 255},
    lambda {|rad| 255},
    lambda {|rad| rad -= SDR*3; 255-c_func(rad)},
    lambda {|rad| 0},
    lambda {|rad| 0}
]
blue_val_f = [
    lambda {|rad| 0},
    lambda {|rad| 0},
    lambda {|rad| rad -= SDR*2; c_func(rad)},
    lambda {|rad| 255},
    lambda {|rad| 255},
    lambda {|rad| rad -= SDR*5; 255-c_func(rad)}
]

img = Image_alpha.new(1000, 1000)
img.fill_ff(center=[500, 500], math_pos=true) do |x, y|
    r = sqrt(x**2 + y**2)
    if r > 500 then next false end
    rad = pos2rad(x, y)
    i = (rad/SDR).to_i
    next Pixel_alpha.new(
        red_val_f[i].call(rad),
        green_val_f[i].call(rad),
        blue_val_f[i].call(rad),
        r/500.0
    )
end
img.write2ppm("pics/shikisokan.ppm")