require "byebug"


class Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i+=1
        end
        self
    end

    def my_select(&prc) 
        new_arr = []
        self.my_each do |i|
            new_arr << i if prc.call(i)
        end
        new_arr
    end

    def my_reject(&prc)
        new_arr = []
        self.my_each do |i|
            new_arr << i if !prc.call(i)
        end
        new_arr
    end

    def my_any?(&prc)
        self.my_each do |i|
            if prc.call(i)
                return true
            end
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |i|
            if !prc.call(i)
                return false
            end
        end
        true
    end

    def my_flatten
        flattened = []
        self.my_each do |ele|
            if ele.is_a?Array
                flattened += ele.my_flatten
            else
                flattened << ele
            end
        end
        flattened
    end

    def my_zip(*arg)
        new_length = arg.length + 1
        new_arr = Array.new(self.length){Array.new(new_length)}
        arg.unshift(self)
        i = 0
        while i < new_length
            (0...self.length).each do |idx|
               new_arr[idx][i] = arg[i][idx]
            end
            i += 1
        end
        new_arr
    end

    def my_rotate(pos=1)
        new_arr = []
        self.my_each { |ele| new_arr << ele }
        if pos > 0
            pos.times do
                new_arr.push(new_arr.shift)
            end
        else
            (pos * -1).times do
                new_arr.unshift(new_arr.pop)
            end
        end
        new_arr
    end

    def my_join(separator="")
        string = ""
        i = 0
        while i < self.length-1
            string += self[i]
            string += separator
            i += 1
        end
        string += self[-1]
    end

    def my_reverse
        new_arr = []
        self.my_each do |ele|
            new_arr.unshift(ele)
        end
        new_arr
    end
end

p [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
p [ 1 ].my_reverse               #=> [1][ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]