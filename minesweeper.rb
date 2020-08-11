
class Minesweeper

    require_relative 'board.rb'

    def initialize()
        @hit_bomb = false 
        @guessed = []
    end

    def run() 
        
        @board = Board.new(2,5)

        puts "Wellcome to Minesweeper!"

        while !@hit_bomb && !@board.win?
            

            @board.render()

            # while game not over run..

            take_turn()
            # take turn 

            # @board.render 
        end
        if @hit_bomb
            puts "Lost :("
        else
            puts "you WON!! noice"
        end

        @board.render()
    end


    def take_turn()
        input = get_input()
        action = input[0]
        pos = input[1]
        
        if action == "r"
            flipped = @board.guess(pos)
            flip_check(flipped,pos)
        elsif action == "f"
            flag(pos)
        end

    end

    def flag(pos)
        puts "Flag!"
        @board.flag(pos)
    end

    def flip_check(val, pos)
        if val == "B"
            lose_case()
        elsif val == "_"
            reveal_recur(pos)
        end

    end

    def reveal_recur(pos)
        puts "reveal Recur!"
        if @board.guess(pos) == "_"  
        
            p surounding = @board.find_boardering(pos)
            surounding.each do |l|
                puts "checking"
                p @board.flipped?(l)
                if !@board.flipped?(l)
                    
                    reveal_recur(l) 
                end

            end
        
        end
        
        @board.render()
    end

    def lose_case()
        puts "Bomb! You Loose!"
        @hit_bomb = true 
    end


    def get_input()
        invalid = true 
        while invalid
            invalid = false
            puts "Enter an 'action, x location, y location'"
            input = gets.chomp.split(",")
            

            if input.length!=3
                invalid = true 
                puts "please only enter 3 things"
            end
            action = input[0]
            pos = [input[1].to_i, input[2].to_i]


            if !valid_action?(action)
                invalid = true 
                puts "please enter a valid action"

            end
            if !valid_location?(pos)
                invalid = true 
                puts "please enter a valid location"
            end
        end

        [action,pos] 
    end

    def valid_action?(char)
        puts "check action"
        p char
        if char == "r"
            puts "reveal"
            return true
        elsif char == "f"
            puts "flag"
            return true
        else
            return false 
        end
    end

    def valid_location?(pos)
        # puts "check location"
        # p pos 
        return false if @guessed.include?(pos)
        return @board.valid_pos?(pos)
    end

end


game = Minesweeper.new()

game.run()