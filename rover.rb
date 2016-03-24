class Rover
  attr_accessor :x, :y, :facing  #x,y = coordinate location, facing = compass direction

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
  attr_accessor :x, :y, :rovers  #maximum x and y grid cordinates (size of grid),
                            #rovers is an array to hold the rovers on the pleteau (essentially rovers sit on the plateau)

  def initialize(x,y)
    @x = x
    @y = y
    @rovers =[]
  end

  def add_rover(rover)
    #pushs a rover into the rover array.
  end

end

class MissionControl
  attr_accessor :initial_states, :instruciton_sets, :plateau_coords

  def initialize
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
    print "(format xy) : "
    self.plateau_coords = gets.chomp


    2.times do
      puts "Enter the inital location coordinates and the compass facing (N,E,S,W) for this rover"
      print "(format xyN) : "
      state_holder = gets.chomp   #holds the state of this rover
      #check to make sure rover is being created at coords that exsist on the plateau
      until ((state_holder[0].to_i <= plateau_coords[0].to_i && state_holder[1].to_i <= plateau_coords[1].to_i)) do
        puts "Those coordinates are outside the orginal plateau, please enter new coordinates."
        print "(format xyN) : "
        state_holder = gets.chomp   #stateHolder is temporary, being used to store current data entry
      end
      puts "Enter the instruction sequence for this rover"
      puts "L = rotate left R=rotate right M = move forward one grid"
      instruction_holder = gets.chomp  #holds the instructions for this rover.
      self.initial_states[state_holder] = instruction_holder
    end
  end

  def create_rovers #create a number of rovers equal to the number of instruction sets sent
    #creates a rover object on the plateu for each key in the hash. 1st rover in first array loaction etc
    #self.initial_states.each do |key|
      test_thingy = Plateau.new(5,5)
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
mission_control.create_rovers
