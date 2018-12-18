class Bbuffer # Both Buffer
    Bcell = Struct.new(:data, :prev, :next) # Both Cell -> Bcell

    def initialize
        @tail = @cur = Bcell.new("EOF", nil, nil)
        @head = Bcell.new("", nil, @cur) # prevが不要となった
        @cur.prev = @head
    end

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

    def at_top?
        return @cur == @head.next
    end

    def top
        @cur = @head.next
    end

    def forward
        if at_end? then return end
        @cur = @cur.next
    end

    def backward # 楽に実装できた
        if at_top? then return end
        @cur = @cur.prev
    end

    def insert(s)
        new_cell = Bcell.new(s, @cur.prev, @cur)
        @cur.prev.next, @cur.prev = new_cell, new_cell
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
            @cur.prev.next = @cur.next
            @cur.next.prev = @cur.prev
            @cur = @cur.next
        end
        # return res.data
    end

    def shift # すべて書き換えなければならないので演習3より実装が大変である。
        if @cur.next == nil then return end
        a, b, c, d = @cur.prev, @cur, @cur.next, @cur.next.next
        a.next = c
        c.prev, c.next = a, b
        b.prev, b.next = c, d
        d.prev = b
        @cur = b
        return @cur
    end

    # 時間の都合上invert!は実装しなかった。
    # def invert!
    
    # end
end