class Cell

	attr_accessor :alive, :neighbors, :next_state

	def initialize

		@alive = false
		@next_state = false
		@neighbors = 0

	end

	def change_life (value)

		@next_state = value

	end

	def to_string

		@alive ? '*' : '.'

	end

  def live
    @alive = true
  end

  def kill
    @alive = false
  end


end

class Grid

	attr_accessor :width, :height, :grid, :table, :input

	def initialize(width, height, input)

		@width = width
		@height = height
    @input = input
		@table = create_grid

	end

	def create_grid

		array = Array.new(@height) {Array.new(@width) {Cell.new} }
    
    @height.times do |row|
			@width.times do |cell|
				@input[row][cell] === '*' ? array[row][cell].live : array[row][cell].kill
			end
		end
		array

	end

	def update_grid
		@height.times do |row|
			@width.times do |cell|
				@table[row][cell].alive = @table[row][cell].next_state
			end
		end
	end




end

class Game

	def initialize(input)
    @input = input
		@grid= Grid.new(input[0].length, input.length, @input)

	end

	def start
		Printer.new(@grid, @grid.table)
		Iteration.new(@grid, @grid.table)
		@grid.update_grid
    Printer.new(@grid, @grid.table)
	end

end

class Iteration

	def initialize (grid,table)

		@grid = grid
    @table = table
		check_status

	end

	def check_status

			@grid.height.times do |row|
				@grid.width.times do |column|

					cell = @table[row][column]

					check_neighbors(column, row)
					cell.next_state = rules(cell)

				end
			end


	end

	def check_neighbors(col,row)
		directions = [[-1,-1],[0,-1],[+1,-1],[-1,0],[+1,0],[-1,+1],[0,+1], [+1,+1] ]
    cell = @table[row][col]
		directions.each do |x,y|
			if check_direction(col+x,row+y)
        @table[row+y][col+x].alive ? cell.neighbors += 1 : cell.neighbors += 0
      end

		end
	end

	def check_direction(x,y)
		return (x>=0 && x<@grid.width && y>=0 && y<@grid.height)
	end

	def rules(cell)
		neighbor = cell.neighbors
		(cell.alive && [2, 3].include?(neighbor) || (!cell.alive && neighbor == 3))
	end


end

class Printer

	def initialize(grid,table)
		grid.height.times do |i|
			grid.width.times do |j|
				print table[i][j].to_string
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
