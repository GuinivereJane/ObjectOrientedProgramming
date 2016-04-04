


class Item

  attr_accessor :catergory, :name, :imported

  attr_reader :tax, :excemptions

  @@excemptions = ['books', 'food', 'medical products']

  def initialize(catergory, description,imported)
    @catergory = catergory
    @imported = imported
    @tax = Object.const_get(set_tax_type).new(false)
    #for this project I am going to set up the excemptions manually
    #I hope that the add and end excemptions method show how easy it is to keep a list of
    #tax excempt items

  end


  def self.add_excemption(excemption)
    @@excemptions << excemption
  end

  def self.end_excemption(excemption)
    @@excemptions.delete excemption
  end

  private

  def set_tax_type
    return 'Import_Tax' if imported
    'Tax'
  end


  def is_excempt?
    @@excemptions.find catergory
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
