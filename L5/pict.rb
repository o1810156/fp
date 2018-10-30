Pixel = Struct.new(:r, :g, :b)

class Image
    def initialize(width, height)
        @width = width
        @height = height
        @canvas = Array.new(height) do
            Array.new(width) do
                Pixel.new(255, 255, 255)
            end
        end
    end

    attr_accessor :width, :height

    def pset(x, y, r, g, b)
        if !(0 <= x and x < @width and 0 <= y and y < @height)
            raise ArgumentError.new "Please pass arguments having proper range."
        end

        @canvas[y][x] = Pixel.new(r, g, b)
    end

    def write2ppm(name)
        if !(name =~ /.*\.ppm$/) then name += ".ppm" end
        open(name, "wb") do |f|
            f.puts("P6\n#{@width} #{@height}\n255")
            @canvas.each do |a|
                a.each do |p|
                    f.write(p.to_a.pack("ccc"))
                end
            end
        end
    end
end