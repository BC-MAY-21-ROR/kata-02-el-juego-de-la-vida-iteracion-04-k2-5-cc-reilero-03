require "minitest/autorun"
require "./game_of_life.rb"

class TestCell < Minitest::Test

  def setup
    @cell = Cell.new
  end

  def test_cell_live
    @cell.live
    assert_equal(@cell.alive, true)
  end

  def test_cell_kill
    @cell.kill
    assert_equal(@cell.alive, false)
  end

  def test_cell_to_string
    @cell.live
    assert_equal(@cell.to_string, "*")
  end

end

# class TestGrid < Minitest::Test

#   def setup
#     input = open_file('./grid.txt')
#     @grid = Grid.new(input[0].length, input.length, @input)
#   end

# end

# def open_file(ruta)
#   file = File.open(ruta)
#   file.readlines.map(&:chomp)
# end
