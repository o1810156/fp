class Dog
    def initialize(name)
        @name = name; @speed = 0.0; @bark_count = 3;
    end
    def talk
        puts("my name is " + @name)
    end
    def addspeed(d)
        @speed = @speed + d
        puts("speed = " + @speed.to_s)
    end

    def bark
        @bark_count.times do
            print(@name)
        end
        puts "!"
    end
    def setcount(n)
        @bark_count = n
    end
end

my_dog = Dog.new("わんこ")
my_dog.talk
my_dog.addspeed(1.0)
my_dog.bark
my_dog.setcount(5)
my_dog.bark
my_dog.setcount(1)
my_dog.bark

# =>
# my name is わんこ
# speed = 1.0
# わんこわんこわんこ!
# わんこわんこわんこわんこわんこ!
# わんこ!
