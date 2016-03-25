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

  def initialize
    @x = 0
    @y = 0
    @rovers =[]
  end

  def add_rover(rover)
    #pushs a rover into the rover array.
    self.rovers.push rover
    self.rovers.reverse!  #reverse order so rovers can be popped of in order they were pushed on
  end

  def is_there_a_rover?(coord_x,coord_y)
    self.rovers.each {|rover| return true if (rover.x == coord_x) && (rover.y == coord_y)}
    false
  end

  def is_coord_on_plateau(coord_x,coord_y)
    return true if coord_x.to_i >= 0 && coord_x.to_i <= x && coord_y.to_i >= 0 && coord_y.to_i <= y
    false
  end

end

class MissionControl
  attr_accessor :initial_rover_states, :instruciton_sets, :plateau

  def initialize
    @initial_rover_states = {}   #hold the instructions read in from the keyboard.  key will be rover start state
                           #element will be the move instructions
    @instruction_sets = [] #index refers to rover number, element refers to instructions for this rover.
    @plateau = Plateau.new  #THE plateau
  end

  #start things up and control the code here

  def go
    self.read_instructions
    self.create_rovers
    self.send_instructions
  end


  def read_instructions  #reads in the initial set of instrcutions
    #reads instructions from the keyboard into a hash.  key = rover inital location, element = string of instructions
    puts "Welcome to mission control, you will now set up your plateau and your rovers"
    puts "please ensure you follow the formating instructions!!!!!"
    puts "Enter the the maximum x and y cordinates of the plateau"
    print "(format xy) : "
    plateau_coords = gets.chomp
    self.build_the_plateau(plateau_coords[0].to_i,plateau_coords[1].to_i)
    collision_on_launch = []
    2.times do
      puts "Enter the inital location coordinates and the compass facing (N,E,S,W) for this rover"
      print "(format xyN) : "
      state_holder = gets.chomp   #holds the state of this rover
      until !(collision_on_launch.include? state_holder[0]+state_holder[1]) do
        puts "Launching a rover to those coordinates would result in a collision"
        print "Please enter new coordinates (format xyN) :"
        state_holder = gets.chomp
      end
      collision_on_launch.push state_holder[0]+state_holder[1]

      #check to make sure rover is being created at coords that exsist on the plateau
      until ((state_holder[0].to_i <= plateau_coords[0].to_i && state_holder[1].to_i <= plateau_coords[1].to_i)) do
        puts "Those coordinates are outside the orginal plateau, please enter new coordinates."
        print "(format xyN) : "
        state_holder = gets.chomp   #stateHolder is temporary, being used to store current data entry
      end

      puts "Enter the instruction sequence for this rover"
      puts "L = rotate left R=rotate right M = move forward one grid"
      instruction_holder = gets.chomp  #holds the instructions for this rover.
      self.initial_rover_states[state_holder] = instruction_holder
    end
  end

  def build_the_plateau(plat_x,plat_y)
    self.plateau.x = plat_x
    self.plateau.y = plat_y
  end


  def create_rovers #create a number of rovers equal to the number of instruction sets sent
    #creates a rover object on the plateu for each key in the hash. 1st rover in first array loaction etc
    self.initial_rover_states.each_key do |rover_state|
      self.plateau.add_rover Rover.new rover_state[0], rover_state[1], rover_state[2]
    end
    #rover order on plateua and instruction set order at mission control need to be kept synchronus


  end

  def send_instructions  #sends instructions to the rovers
    self.initial_rover_states.each do |key, element|
      current_rover = self.plateau.rovers.pop
      element.each_char {|instruction| print "#{instruction},"}
      self.plateau.rovers.insert(0,current_rover)
      puts
    end

puts "testing is on plateau = #{self.plateau.is_coord_on_plateau("9", "1")}"

    #iterate through inital_states to find insturction sets when needed using |key,Element|

    #work through instruction array sending all moves for each rover, one at a time, then moveing onto next rover,
    #if rover reports a hazard stop movement, track final location and report reason for stoping
  end
end


MissionControl.new.go
