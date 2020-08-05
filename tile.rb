

class Tile 

    def initialize()
        @bomb = false # true or false
        @hidden = false 
        @bordering_bombs = 0  
    end

    def add_border_bomb
        @bordering_bombs +=1
    end

    def bomb?
        @bomb
    end

    def place_bomb
        @bomb = true 
    end

    def bordering_bombs
        return "B" if @bomb
        return @bordering_bombs if !@hidden
        return "X"
    end

    def flip
        @hidden = false 
        bordering_bombs()
    end




end
