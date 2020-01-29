import Pos from require 'pos'

class Fruit
  new: =>
    row = love.math.random(ROWS)
    col = love.math.random(COLS)
    @pos = Pos row, col

  draw: =>
    row, col = @pos\pos!
    x = (col - 1) * BLOCK_DIM
    y = (row - 1) * BLOCK_DIM
    love.graphics.rectangle 'fill', x, y, BLOCK_DIM, BLOCK_DIM

{ :Fruit }
