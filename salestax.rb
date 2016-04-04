
class Item

  attr_accessor :catergory, :name, :imported, :tax, :excemptions

  attr_reader

  #for this project I am going to set up the excemptions manually
  #I hope that the add and end excemptions method show how easy it is to keep a list of
  #tax excempt items, in a larger scale version this list would be stored somewhere and mainted
  @@excemptions = ['books', 'food', 'medical products']

  def initialize(description, imported)
    @catergory = set_catergory(description)
    @imported = imported
    @tax = Object.const_get(set_tax_type).new(is_excempt?)
  end

  def self.add_excemption(excemption)
    @@excemptions << excemption
  end

  def self.end_excemption(excemption)
    @@excemptions.delete excemption
  end

  def self.return_excemptions
    @@excemptions
  end

  private
  def set_catergory(item)
    #in a better designed system this would be captured on data entry
    print "Please enter the category that #{item} belongs to : "
    gets.chomp
  end

  def set_tax_type
    return 'Import_Tax' if imported
    'Tax'
  end

  def is_excempt?
    @@excemptions.find {|i| i == catergory}
  end

end

class Tax

  attr_accessor :tax_rate, :excempt

  def initialize(excempt)
    excempt ? @tax_rate = 0 : @tax_rate = 0.1
  end
  def calculate_tax(price)
    tax = tax_rate * price
    tax.round(2)
  end

end

class Import_Tax < Tax
  def initialize(excempt)
    super(excempt)
    @tax_rate = @tax_rate + 0.05
  end
end

class Shopping_cart
  attr_accessor :cart_contents

  def initialize
    @cart_contents = []
  end

  def add_to_cart(item)
    cart_contents << item
  end


end


#for testing purposes

#the following code is for testing only
input1 = "1 book at 12.49 \n1 music CD at 14.99 \n1 chocolate bar at 0.85"
input2 = "1 imported box of chocolates at 10.00 \n1 imported bottle of perfume at 47.50"
input3 = "1 imported bottle of perfume at 27.99 \n1 bottle of perfume at 18.99 \n1 packet of headache pills at 9.75 \n1 box of imported chocolates at 11.25"

def split_input_string(input_string)
  input_string.split
end

def fill_cart(input_string)
  #takes one string and adds it to the cart
  imported = true if input_string.include? "imported"

  input_split = input_string.split

  number_of_items = input_split.shift

  price = input_split.pop
  input_split.pop
  price = price.to_f

  description = input_split.join " "

end

puts fill_cart('1 imported bottle of perfume at 27.99 ')
