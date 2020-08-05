

class Board 

    require_relative 'tile.rb'

    def initialize(bomb_count = 9, board_size = 9) 
        @board = Array.new(board_size)  {Array.new(board_size) {Tile.new()}  }
        add_bombs(bomb_count, board_size)

    end

    def [](x,y)
        @board[x][y] 
    end

    def add_bombs(bomb_count, board_size)
        bomb_locations = pick_bombs(bomb_count, board_size)
        
        bomb_locations.each do |pos|
            @board[pos[0]][pos[1]].place_bomb
        end 
            
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
        puts "  " + (0...@board.length).to_a.join(" ")
        @board.each_with_index do |row, i| 
            print  i 
            row.each do |t|
                print " "+ (t.bordering_bombs).to_s 
            end
            puts ""
        end
    end


end


b = Board.new()

b.render 

