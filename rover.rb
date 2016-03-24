class rover
  attr_accessor: x,y, facing  #x,y = coordinate location, facing = compass direction

  def initialize(x,y,facing)
    @x = x
    @y = y
    @facing = facing
  end

  def move  #moves rover forward one grid
  end

  def turn #rotates rover left or right 90 degrees
  end


end

class plateau
  attr_accessor: x,y,rovers  #maximum x and y grid cordinates (size of grid), rovers is an array to hold the rovers on the pleteau

  def initialize(x,y,rovers)
    @x = x
    @y = y
    @rovers =[]
end

class mission_control
end
