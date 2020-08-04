

class Board 

    def initialize(bomb_count = 9, board_size = 9) 
        @board = Array.new(board_size) {Array.new(board_size, new.Tile(0)) }

    end


end

