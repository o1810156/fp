class Buffer
    Cell = Struct.new(:data, :next)

    def initialize
        @tail = @cur = Cell.new("EOF", nil)
        @head = @prev = Cell.new("", @cur)
    end

    attr :cur # getter

    def inspect
        ptr = @head.next
        while ptr != nil
            printf("#{ptr.data}\\n")
            ptr = ptr.next
        end
        puts
    end

    def at_end?
        return @cur == @tail
    end

    def top
        @prev = @head
        @cur = @head.next
    end

    def forward
        if at_end? then return end
        @prev = @cur
        @cur = @cur.next
    end

    def insert(s)
        @prev.next = Cell.new(s, @cur)
        @prev = @prev.next
    end

    def print
        puts(" " + @cur.data)
    end

    def print_all
        ptr = @head.next
        while ptr != nil
            puts ptr.data
            ptr = ptr.next
        end
    end

    def delete
        # res = @cur
        if @cur.next != nil # == `if @cur.data == "EOF" then return end`
            @prev.next, @cur = @cur.next, @cur.next
        end
        # return res.data
    end

    def shift
        if @cur.next != nil and @cur.next.next != nil
            a = @cur
            b = @cur.next
            a.next, b.next = b.next, a
            @cur, @prev.next = b, b
        end
        return @cur.data
    end

    def backward
        if @cur == @head then return end
        # 頭から探索しなおすしかない。
        # 各リストを区別する値はnextの中身なのでこれを利用する
        ptr = @head
        while ptr.next != nil
            if ptr.next == @prev
                @prev, @cur = ptr, @prev
                break
            end
            ptr = ptr.next
        end
        return @cur.data
    end

    # 演習 1を流用

    def invert!
        res = Cell.new("EOF", nil)
        ptr = @head.next # 先頭はダミーだったのでその次
        while ptr.next != nil
            res = Cell.new(ptr.data, res)
            ptr = ptr.next
        end
        @head = Cell.new("", res) # ダミーを先頭につける
    end

    # 以下 演習5

    def subst(str)
        if at_end? then return end
        a = str.split("/")
        @cur.data[Regexp.new(a[1])] = a[2]
    end

    def read(file)
        open(file, "r") do |f|
            f.each do |s| insert(s) end
        end
    end

    def save(file)
        top
        open(file, "w") do |f|
            while not at_end? do
                f.puts(@cur.data)
                forward
            end
        end
    end
end