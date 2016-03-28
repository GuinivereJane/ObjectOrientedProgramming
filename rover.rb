class Rover
  attr_accessor :x, :y, :facing  #x,y = coordinate location, facing = compass direction

  NORTH = 1
  EAST = 2
  SOUTH = 3
  WEST = 4

  def initialize(x,y,facing)
    @x = x.to_i
    @y = y.to_i
    @facing = 0

    case facing
    when "N"
      self.facing = NORTH
    when "E"
      self.facing = EAST
    when "S"
      self.facing = SOUTH
    when "W"
      self.facing = WEST
    end

  end

  def look_before_you_leap
    #this returns a array [x,y], x and y are the cordinates that the rover will be at if it moves forward
    case self.facing
    when NORTH
      return [x,self.y+1]
    when EAST
      return [self.x+1,y]
    when SOUTH
      return [x,self.y-1]
    when WEST
      return [self.x-1,y]
    end
  end

  def move
    case self.facing
    when NORTH
      self.y += 1
    when EAST
      self.x += 1
    when SOUTH
      self.y -= 1
    when WEST
      self.x -= 1
    end

  end

  def turn(direction)#rotates rover left or right 90 degrees
    case direction
    when "R"
      self.facing == 4 ? self.facing = 1 : self.facing += 1
    when "L"
      self.facing == 1 ? self.facing = 4 : self.facing -= 1
    end
  end

  def status_report
    print "#{self.x} #{self.y} "
    case self.facing
    when NORTH
      puts "N"
    when EAST
      puts "E"
    when SOUTH
      puts "S"
    when WEST
      puts "W"
    end
  end


end

class Plateau
  attr_accessor :x, :y, :rovers  #maximum x and y grid cordinates (size of grid),

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

  def is_coord_off_plateau?(coord_x,coord_y)
    return true if coord_x.to_i < 0 || coord_x.to_i > x || coord_y.to_i < 0 || coord_y.to_i > y
    false
  end

end

class MissionControl
  attr_accessor :initial_rover_states, :instruciton_sets, :plateau

  def initialize
    @initial_rover_states = {}   #hold the instructions read in from the keyboard.  key will be rover start state
    @instruction_sets = [] #index refers to rover number, element refers to instructions for this rover.
    @plateau = Plateau.new  #THE plateau
  end

  #start things up and control the code here

  def go
    self.read_instructions
    self.create_rovers
    self.send_instructions
    self.check_rovers
  end


  def read_instructions  #reads in the initial set of instrcutions
    #reads instructions from the keyboard into a hash.  key = rover inital location, element = string of instructions
    puts "Welcome to mission control, you will now set up your plateau and your rovers"
    puts "please ensure you follow the formating instructions!!!!!"
    puts "Enter the the maximum x and y cordinates of the plateau"
    print "(format x y) : "
    plateau_coords = gets.chomp
    self.build_the_plateau(plateau_coords[0].to_i,plateau_coords[2].to_i)
    collision_on_launch = []
    2.times do
      puts "Enter the inital location coordinates and the compass facing (N,E,S,W) for this rover"
      print "(format x y N) : "
      state_holder = gets.chomp   #holds the state of this rover
      until !(collision_on_launch.include? state_holder[0]+state_holder[2]) do
        puts "Launching a rover to those coordinates would result in a collision"
        print "Please enter new coordinates (format xyN) :"
        state_holder = gets.chomp
      end
      collision_on_launch.push state_holder[0]+state_holder[2]

      #check to make sure rover is being created at coords that exsist on the plateau
      until ((state_holder[0].to_i <= plateau_coords[0].to_i && state_holder[2].to_i <= plateau_coords[2].to_i)) do
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
      self.plateau.add_rover Rover.new rover_state[0], rover_state[2], rover_state[4]
    end
  end

  def send_instructions  #sends instructions to the rovers
    self.initial_rover_states.each do |key, element|
      current_rover = self.plateau.rovers.pop
      element.each_char do |inst|
        case inst
        when "L", "R"
          current_rover.turn inst
        when "M"
#rover will not move if the next move will endanger it
          next_move = current_rover.look_before_you_leap
          problem = true if self.plateau.is_there_a_rover?(next_move[0], next_move[1])
          problem = true if self.plateau.is_coord_off_plateau?(next_move[0], next_move[1])

          problem |= false
          if problem
          else
            current_rover.move
          end
        end
        end
      self.plateau.rovers.insert(0,current_rover)
      puts
    end
  end

  def check_rovers
    self.plateau.rovers.reverse_each {|rover| rover.status_report}
  end
end


MissionControl.new.go
