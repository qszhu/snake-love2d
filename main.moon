export ROWS, COLS = 24, 32
export INIT_LEN, INIT_INTERVAL, SPEED_UP = 5, 0.5, 0.1
export DIR_UP, DIR_RIGHT, DIR_DOWN, DIR_LEFT = 1, 2, 3, 4
export BLOCK_DIM

import Fruit from require 'fruit'
import Snake from require 'snake'

local snake, fruit
local elapsed, interval, running

newFruit = ->
  fruit = Fruit!
  while snake\onHead(fruit.pos) and snake\onBody(fruit.pos)
    fruit = Fruit!

init = ->
  startRow = math.floor(ROWS / 2)
  startCol = math.floor((COLS - INIT_LEN) / 2)
  snake = Snake startRow, startCol
  newFruit!

  elapsed = 0
  interval = INIT_INTERVAL
  running = true

gameOver = ->
  running = false

love.load = (arg) ->
  w, h = love.graphics.getDimensions!
  BLOCK_DIM = math.floor(h / ROWS)

  init!
  print 'loaded'

love.update = (dt) ->
  if love.keyboard.isDown 'escape'
    love.event.quit!

  if not running
    if love.keyboard.isDown 'k' then init!
    else return

  if love.keyboard.isDown 'up'
    snake\up!
  elseif love.keyboard.isDown 'down'
    snake\down!
  elseif love.keyboard.isDown 'left'
    snake\left!
  elseif love.keyboard.isDown 'right'
    snake\right!

  elapsed += dt
  if elapsed < interval then return
  elapsed -= interval

  snake\step!

  if snake\eatFruit fruit
    newFruit!
    interval *= 1 - SPEED_UP

  if snake\collidesSelf! then gameOver!

love.draw = ->
  snake\draw!
  fruit\draw!
