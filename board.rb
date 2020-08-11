

class Board 

    require_relative 'tile.rb'

    def initialize(bomb_count = 9, board_size = 9) 
        @board = Array.new(board_size)  {Array.new(board_size) {Tile.new()}  }
        add_bombs(bomb_count, board_size)
        

    end

    def flipped?(pos)
        !get_t(pos).hidden?()
    end

    def get_t(pos)
        @board[pos[0]][pos[1]]
    end

    def guess (pos)
        get_t(pos).flip 
    end

    def add_bombs(bomb_count, board_size)
        bomb_locations = pick_bombs(bomb_count, board_size)
        
        bomb_locations.each do |pos|
            get_t(pos).place_bomb
            add_bordering(pos)
        end 
        
    end

    def add_bordering(pos)
        find_boardering(pos).each do |b|
            get_t(b).add_border_bomb
        end
    end


    def find_boardering(pos)
        arr = []

        r = pos[0]
        c = pos[1]

        if c+1 < @board.length # col+ is good 
            arr << [r,c+1]
            if r+1 < @board.length # row+ good 
                arr << [r+1,c+1]
            end
            if r-1>=0 # row- good 
                arr << [r-1,c+1]
            end
        end
        if c-1 >= 0 # col- is good 
            arr << [r,c-1]
            if r+1 < @board.length # row+ good 
                arr << [r+1,c-1]
            end
            if r-1>=0 # row- good 
                arr << [r-1,c-1]
            end
        end
        arr << [r+1,c] if r+1 < @board.length # row + good 
        arr << [r-1,c] if r-1 >= 0 # row - good 

        arr
    end

    def is_hidden?(pos)
        get_t(pos).hidden?
    end


    def pick_bombs(bomb_count, board_size)
        arr = [*0..(board_size-1)**2].shuffle
        arr = arr[0...bomb_count]
        bomb_locations = []
        arr.each do |i|
            loc = []
            x = i / board_size
            y = i % board_size 
            bomb_locations << [x,y] 
        end
        bomb_locations
    end

    def render()
        puts "     " + (0...@board.length).to_a.join(" ")
        puts"    "
        @board.each_with_index do |row, i| 
            print  " "+i.to_s + "  "
            row.each do |t|
                print " "+ (t.bordering_bombs).to_s 
            end
            puts ""
        end
        puts""
    end

    def valid_pos?(pos)
        x = pos[0]
        y = pos[1]

        if x >= @board.length || x < 0
            puts "x out of bounds"
            return false 
        elsif y >= @board.length || y < 0
            puts "y out of bounds"
            return false 
        elsif !@board[x][y].hidden?
            puts "location already guessed!"
            return false 
        else 
            return true
        end

    end

    def win?()
        @board.each do |r|
            r.each do |t|
                return false if !t.bomb? && t.hidden?
            end
        end
        true 
    end

    def flag(pos)
        get_t(pos).flag = true 
    end

end



