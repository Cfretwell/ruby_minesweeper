

class Board 

    require_relative 'tile.rb'

    def initialize(bomb_count = 9, board_size = 9) 
        @board = Array.new(board_size)  {Array.new(board_size) {Tile.new()}  }
        add_bombs(bomb_count, board_size)

    end

    def guess (x,y)
        @board[x][y].flip 
    end

    def add_bombs(bomb_count, board_size)
        bomb_locations = pick_bombs(bomb_count, board_size)
        
        bomb_locations.each do |pos|
            @board[pos[0]][pos[1]].place_bomb
            add_bordering(pos)
        end 
        
    end

    def add_bordering(pos)
        find_boardering(pos).each do |b|
            @board[b[0]][b[1]].add_border_bomb
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
        if c-1 < @board.length # col+ is good 
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

    def render 
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


end




