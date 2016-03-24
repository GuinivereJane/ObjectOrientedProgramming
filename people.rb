class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def greeting
    puts "Hi my name is #{name}"
  end

end



class Students < Person

  def learn
    puts "I get it !"
  end

end

class Instructors < Person
  def teach
    puts"Everything in Ruby is an object !"
  end
end

Chris = Instructors.new "Chris"
Chris.greeting

Christina = Students.new "Christina"
Christina.greeting
