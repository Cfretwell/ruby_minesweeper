

class Tile 

    def initialize()
        @bomb = false # true or false
        @hidden = true  
        @flag = false
        @bordering_bombs = 0  
    end

    def hidden?()
        @hidden 
    end

    def bomb?()
        @bomb
    end

    def add_border_bomb
        @bordering_bombs +=1
    end

    def place_bomb
        @bomb = true 
    end

    def bordering_bombs
        return "F" if @flag
        return "*" if @hidden
        return "B" if @bomb 
        return "_" if @bordering_bombs ==0
        return @bordering_bombs if !@hidden
        # return "H"
    end

    def flip
        @hidden = false 
        @flag = false 
        bordering_bombs()
    end

    def flag=(val)
        @flag = !!val
    end




end
