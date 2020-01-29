class Pos
  new: (row, col) =>
    @row, @col = row, col

  pos: =>
    @row, @col

  equals: (other) =>
    row, col = other\pos!
    @row == row and @col == col

{ :Pos }
