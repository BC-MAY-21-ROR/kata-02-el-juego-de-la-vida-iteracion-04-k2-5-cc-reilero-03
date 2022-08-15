class Cell

    attr_accessor :alive, :neighbors

    def initialize
    
        @alive = false
        @next_state = false
        @neighbors = 0

    end

    def change_life (value)
    
        @next_state = value

    end

    def  to_string

        @alive ? "*" : "."

    end


end

class Grid

    def initialize(width, height)

        @width = width
        @height = height
        @grid = create_grid
        
    end

    def create_grid

        @array = Array.new(@height, Array.new(@width){Cell.new})

    end




end

class Game

    def initialize(input)

        @grid= Grid.new(input[0].length, input.length)
    
    end

end 

class Iteration

    def initialize (grid)

        @grid = grid

    end

    def check_status

        @grid.height.times do |row|
            @grid.width.times do |column|

                cell = @grid[row][column]


            end 
        end


    end 

    def check_neighbors(col,row)
        directions = [[-1,-1],[0,-1],[+1,-1],[-1,0],[+1,0],[-1,+1],[0,+1], [+1,+1] ]
            directions.each do |x,y|
                check_direction(col+x,row+y) && @grid[x][y].alive ? @grid[col][row].neighbors += 1 :  @grid[col][row].neighbors += 0
            end
        end 
    end

    def check_direction(x,y)
        return (x>=0 && y>=0 && x<@grid.width && y<@grid.height)
    end


end 

def open_file(ruta)
    file = File.open(ruta)
    file.readlines.map(&:chomp)
    end
    
    data = open_file('generation.text')
