import Pos from require 'pos'

class Snake
  new: (row, col) =>
    @body = {}
    for i = 1, INIT_LEN
      @body[i] = Pos row, col + i - 1
    @dir = DIR_LEFT
    @dr = { -1, 0, 1, 0 }
    @dc = { 0, 1, 0, -1 }
    @hasFruit = false
    @lockInput = false -- only accept input after step

  turnRight: =>
    if @lockInput then return
    @lockInput = true

    @dir = @dir % 4 + 1

  turnLeft: =>
    if @lockInput then return
    @lockInput = true

    @dir = (@dir + 2) % 4 + 1

  up: =>
    if @dir == DIR_LEFT then @turnRight!
    elseif @dir == DIR_RIGHT then @turnLeft!

  down: =>
    if @dir == DIR_RIGHT then @turnRight!
    elseif @dir == DIR_LEFT then @turnLeft!

  left: =>
    if @dir == DIR_DOWN then @turnRight!
    elseif @dir == DIR_UP then @turnLeft!

  right: =>
    if @dir == DIR_UP then @turnRight!
    elseif @dir == DIR_DOWN then @turnLeft!

  step: =>
    row, col = @body[1]\pos!

    nrow = row + @dr[@dir]
    if nrow < 1 then nrow += ROWS
    if nrow > ROWS then nrow = 1

    ncol = col + @dc[@dir]
    if ncol < 1 then ncol += COLS
    if ncol > COLS then ncol = 1

    if @hasFruit
      table.insert @body, 1, Pos nrow, ncol
      @hasFruit = false
      return

    for i = #@body, 2, -1
      @body[i] = @body[i-1]

    @body[1] = Pos nrow, ncol
    @lockInput = false

  draw: =>
    for i = 1, #@body
      row, col = @body[i]\pos!
      x = (col - 1) * BLOCK_DIM
      y = (row - 1) * BLOCK_DIM
      love.graphics.rectangle 'fill', x, y, BLOCK_DIM, BLOCK_DIM

  onHead: (pos) => pos\equals @body[1]

  onBody: (pos) =>
    for i = 2, #@body
      if pos\equals @body[i] then return true
    return false

  collidesSelf: =>
    @onBody @body[1]

  eatFruit: (fruit) =>
    if @onHead fruit.pos
      @hasFruit = true
      return true
    return false

{ :Snake }
