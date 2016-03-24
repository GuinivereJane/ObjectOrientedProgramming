class Rover
  attr_accessor: x,y, facing  #x,y = coordinate location, facing = compass direction

  def initialize(x,y,facing)
    @x = x
    @y = y
    @facing = facing
  end

  def move  #1) checks if move is safe (not off edge, no collision)
            #2) moves rover
            #Return final x,y cordinates and facing
  end

  def turn #rotates rover left or right 90 degrees
            #called from rover.move
  end


end

class Plateau
  attr_accessor: x,y,rovers  #maximum x and y grid cordinates (size of grid),
                            #rovers is an array to hold the rovers on the pleteau (essentially rovers sit on the plateau)

  def initialize(x,y,rovers)
    @x = x
    @y = y
    @rovers =[]
  end

  def add_rover(rover)
    #pushs a rover into the rover array.
  end

end

class MissionControl
  attr_accessor: intial_states, instruciton_sets, plateau_cords

  def initialize(intial_states, instruciton_sets)
    @initial_states = {}   #hold the instructions read in from the keyboard.  key will be rover start state
                           #element will be the move instructions
    @instruction_sets = [] #index refers to rover number, element refers to instructions for this rover.
    @plateau_coords = "00"  #x,y cordintes of the maximum postions on the plateau
  end

  def read_instructions  #reads in the initial set of instrcutions
    #reads instructions from the keyboard into a hash.  key = rover inital location, element = string of instructions
    puts "Welcome to mission control, you will now set up your plateau and your rovers"
    puts "please ensure you follow the formating instructions!!!!!"
    puts "Enter the the maximum x and y cordinates of the plateau"
    print "(formant xy) : "
    plateau_cords = gets.chomp

  end

  def create_rovers #create a number of rovers equal to the number of instruction sets sent
    #creates a rover object on the plateu for each key in the hash. 1st rover in first array loaction etc
    #each rover gets an inital location and faciing
    #then creates an instruction set array at mission control. instructions for first rover located in 1 element, etc
    #rover order on plateua and instruction set order at mission control need to be kept synchronus
  end

  def send_instructions  #sends instructions to the rovers
    #work through instruction array sending all moves for each rover, one at a time, then moveing onto next rover,
    #if rover reports a hazard stop movement, track final location and report reason for stoping
  end
end


mission_control = MissionControl.new
mission_control.read_instructions
