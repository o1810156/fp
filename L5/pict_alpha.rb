# "pict.rb"を根本的に改良し、alphaチャンネルに対応させた
load "pict.rb"

Pixel_alpha = Struct.new(:r, :g, :b, :alpha)

class Image
    def draw_alpha_layer(layer)
        if @width != layer.width or @height != layer.height then raise ArgumentError.new "サイズが合いません。" end
        if layer.class != Image_alpha then raise ArgumentError.new "layer must be Image_alpha." end

        base = Image_alpha.new(@width, @height)
        base.canvas = base.canvas.map {|row|
            row.map {|c|
                Pixel_alpha.new(255, 255, 255, 1)
            }
        }
        layer = base + layer

        layer.canvas.map.with_index do |row, y|
            row.map.with_index do |pix, x|
                # @canvas[y][x] = Pixel.new(*([pix.r, pix.g, pix.b].map {|c| (c*(1 - pix.alpha)).to_i}))
                @canvas[y][x] = Pixel.new(pix.r, pix.g, pix.b)
            end
        end
    end
end

class Image_alpha
    def initialize(width, height)
        @width = width
        @height = height
        @canvas = Array.new(height) do
            Array.new(width) do
                Pixel_alpha.new(255, 255, 255, 0)
            end
        end
    end

    attr_accessor :width, :height, :canvas

    def pset(x, y, r, g, b, alpha=1)
        if !(0 <= x and x < @width and 0 <= y and y < @height)
            raise ArgumentError.new "Please pass arguments having proper range."
        end
        if alpha < 0 or 1 < alpha
            puts "alpha: #{alpha}"
            raise ArgumentError.new "Please pass proper alpha channel [0, 1]."
        end

        @canvas[y][x] = Pixel_alpha.new(r, g, b, alpha)
    end

    # 演習 4 e 美しい絵を描くのにあると良い機能 : Layer機能

    # [wikipedia](https://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%AB%E3%83%95%E3%82%A1%E3%83%96%E3%83%AC%E3%83%B3%E3%83%89)によると
    
    # out_A = src_A + dst_A * (1 - src_A)
    # out_rgb = out_A != 0 ? (src_rgb * src_A + dst_rgb * dst_A * (1 - src_A)) / out_A : 0

    # という計算式でαブレンドができる。

    def blend(other)
        if @width != other.width or @height != other.height then raise ArgumentError.new "サイズが合いません。" end

        o = other.canvas # src
        c = @canvas # dst

        canvas = c.map.with_index {|row, y|
            row.map.with_index {|pix, x|
                alpha = o[y][x].alpha + pix.alpha * (1 - o[y][x].alpha)
                rgb = [:r, :g, :b].map {|col|
                    res = alpha != 0 ? (o[y][x][col] * o[y][x].alpha + pix[col] * pix.alpha * (1 - o[y][x].alpha))/alpha : 0
                    res.to_i
                }
                Pixel_alpha.new(*rgb, alpha)
            }
        }
        tmp = Image_alpha.new(@width, @height)
        tmp.canvas = canvas
        return tmp
    end

    def +(other)
        return blend(other)
    end

    def ride!(other, bx, by)
        o = other.canvas # src
        c = @canvas # dst

        o.each_with_index {|row, y|
            y += by
            row.each_with_index {|pix, x|
                x += bx
                alpha = pix.alpha + c[y][x].alpha * (1 - pix.alpha)
                rgb = [:r, :g, :b].map {|col|
                    res = alpha != 0 ? (pix[col] * pix.alpha + c[y][x][col] * c[y][x].alpha * (1 - pix.alpha))/alpha : 0
                    res.to_i
                }
                c[y][x] = Pixel_alpha.new(*rgb, alpha)
            }
        }
    end

    def write2ppm(name)
        img = Image.new(@width, @height)
        img.draw_alpha_layer(self)
        img.write2ppm(name)
    end
end