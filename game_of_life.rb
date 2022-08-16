class Cell
  attr_accessor :alive, :neighbors, :next_life_state

  def initialize
    @alive = false
    @next_life_state = false
    @neighbors = 0
  end

  def change_life(value)
    @next_life_state = value
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
    grid_board = Array.new(@height) { Array.new(@width) { Cell.new } }

    @height.times do |row|
      @width.times do |cell|
        @input[row][cell] === '*' ? grid_board[row][cell].live : grid_board[row][cell].kill
      end
    end
    grid_board
  end

  def update_grid
    @height.times do |row|
      @width.times do |cell|
        @table[row][cell].alive = @table[row][cell].next_life_state
      end
    end
  end
end

class Game
  def initialize(input)
    @input = input
    @grid = Grid.new(input[0].length, input.length, @input)
  end

  def start
    Printer.new(@grid, @grid.table)
    Iteration.new(@grid, @grid.table)
    @grid.update_grid
    Printer.new(@grid, @grid.table)
  end
end

class Iteration
  def initialize(grid, table)
    @grid = grid
    @table = table
    check_status
  end

  def check_status
    @grid.height.times do |row|
      @grid.width.times do |column|
        cell = @table[row][column]

        check_neighbors(column, row)
        cell.next_life_state = rules(cell)
      end
    end
  end

  def check_neighbors(col, row)
    directions = [[-1, -1], [0, -1], [+1, -1], [-1, 0], [+1, 0], [-1, +1], [0, +1], [+1, +1]]
    cell = @table[row][col]
    directions.each do |pos_x, pos_y|
      if check_direction(col + pos_x, row + pos_y)
        cell.neighbors += @table[row + pos_y][col + pos_x].alive ? 1 : 0
      end
    end
  end

  def check_direction(pos_x, pos_y)
    (pos_x >= 0 && pos_x < @grid.width && pos_y >= 0 && pos_y < @grid.height)
  end

  def rules(cell)
    neighbor = cell.neighbors
    (cell.alive && [2, 3].include?(neighbor) || (!cell.alive && neighbor == 3))
  end
end

class Printer
  def initialize(grid, table)
    grid.height.times do |i|
      grid.width.times do |j|
        print table[i][j].to_string
      end
      puts ''
    end
    puts ' '
  end
end

def open_file(ruta)
  file = File.open(ruta)
  file.readlines.map(&:chomp)
end

data = open_file('./grid.txt')

game = Game.new(data)
game.start
