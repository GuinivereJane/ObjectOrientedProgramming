require 'pry-byebug'

class Item

  attr_accessor :catergory, :name, :imported, :tax, :excemptions, :price


  #for this project I am going to set up the excemptions manually
  #I hope that the add and end excemptions method show how easy it is to keep a list of
  #tax excempt items, in a larger scale version this list would be stored somewhere and mainted
  @@excemptions = ['books', 'food', 'medical products']

  def initialize(name, imported, price)
    @catergory = set_catergory(name)
    @imported = imported
    @price = price
    @name = name
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

  def display_contents
    cart_contents.map { |item| puts "1 #{item.name} : #{item.price}"}
  end

end

class Cash_register
  attr_accessor :cart

  def initialize(cart)
    @cart = cart
  end

  def display_invoice
    total_tax = 0.0
    total_price = 0.0
    cart.cart_contents.map do |item|
      tax_rate = item.tax.tax_rate
      tax_amount = item.price * tax_rate
      tax_amount *= 20
      tax_amount = tax_amount.ceil.to_f
      tax_amount /= 20
      tax_amount = tax_amount.round(2)

      price_including_tax = tax_amount + item.price
      puts "1 #{item.name} : #{'%.2f' % price_including_tax}"
      total_tax += tax_amount
      total_price += price_including_tax
    end
    puts "Sales Taxes: #{sprintf("%0.02f", total_tax)}"
    puts "Total: #{sprintf("%0.02f",total_price)}"
  end
end


#for testing purposes

#the following code is for testing only
class Salestax_test_drive

  attr_accessor :input, :shopping_cart

  def initialize(input)
    @input = input
    @shopping_cart = Shopping_cart.new
  end

  def split_input_string(input_string)
    input_string.split "\n"
  end

  def fill_cart
    #take input split it into an array with split_inout_string
    item_test_data = split_input_string(input)
    #send index by index to parse it, parse returns array of item attributes
    item_test_data.map do |item_data_string|
      item_attribute_array = parse_input_string(item_data_string)
      new_item = Item.new(item_attribute_array[0], item_attribute_array[1], item_attribute_array[2])

      shopping_cart.add_to_cart new_item
    end
  end

  def go
    fill_cart
    Cash_register.new(shopping_cart).display_invoice
  end


  def parse_input_string(input_string)
    #takes one string and adds it to the cart
    imported = true if input_string.include? "imported"

    input_split = input_string.split

    number_of_items = input_split.shift

    price = input_split.pop
    input_split.pop
    price = price.to_f

    description = input_split.join " "

    item_array = [description, imported, price]
  end
end


input1 = "1 book at 12.49 \n1 music CD at 14.99 \n1 chocolate bar at 0.85"
input2 = "1 imported box of chocolates at 10.00 \n1 imported bottle of perfume at 47.50"
input3 = "1 imported bottle of perfume at 27.99 \n1 bottle of perfume at 18.99 \n1 packet of headache pills at 9.75 \n1 box of imported chocolates at 11.25"


Salestax_test_drive.new(input1).go

Salestax_test_drive.new(input2).go


Salestax_test_drive.new(input3).go
