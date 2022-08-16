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

	attr_accessor :width, :height, :grid

	def initialize(width, height)

		@width = width
		@height = height
		@grid = create_grid

	end

	def create_grid

		@array = Array.new(@height, Array.new(@width){Cell.new})
		@array

	end

	def update_grid
		@grid.each do |row|
			row.each do |cell|
				grid[row][cell].alive = grid[row][cell].next_state
			end
		end
	end




end

class Game

	def initialize(input)

		puts input[0].length
		puts input.length
		@grid= Grid.new(input[0].length, input.length)
		@grid = @grid.grid
		puts @grid

	end

	def start
		Printer.new(@grid)
		Iteration.new(@grid)
		@grid.update_grid
	end

end

class Iteration

	def initialize (grid)

		@grid = grid
		check_status

	end

	def check_status

			@grid.height.times do |row|
				@grid.width.times do |column|

					cell = @grid[row][column]

					check_neighbors(column, row)
					cell.nextState = rules(cell)

				end
			end


	end

	def check_neighbors(col,row)
		directions = [[-1,-1],[0,-1],[+1,-1],[-1,0],[+1,0],[-1,+1],[0,+1], [+1,+1] ]
		directions.each do |x,y|
			check_direction(col+x,row+y) && @grid[x][y].alive ? @grid[col][row].neighbors += 1 :  @grid[col][row].neighbors += 0
		end
	end

	def check_direction(x,y)
		return (x>=0 && y>=0 && x<@grid.width && y<@grid.height)
	end

	def rules(cell)
		neighbor = cell.neighbor
		(cell.alive? && [2, 3].include?(neighbor) || (!cell.alive? && neighbor == 3))
	end


end

class Printer

	def initialize(grid)
		grid.height.times do |i|
			grid.width.times do |j|
				puts grid[i][j].to_string
			end
			puts ""
	end
	puts " "
	end

end

def open_file(ruta)
	file = File.open(ruta)
	file.readlines.map(&:chomp)
end

	data = open_file('./grid.txt')

game = Game.new(data)
game.start
