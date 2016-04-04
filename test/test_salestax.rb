require 'minitest/autorun'
require 'minitest/pride'
require './salestax'

class TestSalestax < MiniTest::Test

  def setup
    @item = Item.new('medicine','pills',false)
    @taxable = Tax.new(false)
    @excempt = Tax.new(true)
    @import = Import_Tax.new(false)
    @excempt_import = Import_Tax.new(true)
  end

  def test_add_excemption
    Item.add_excemption 'medicine'
    assert_equal ['books', 'food', 'medical products', 'medicine'], Item.excemptions
  end

def test_end_excemption
  Item.end_excemption 'medicine'
  assert_equal ['books', 'food', 'medical products'], Item.excemptions
end



  def test_tax_one_dollar
    assert_equal 0.1, @taxable.calculate_tax(1)
  end
  def test_import_tax_one_dollar
    assert_equal 0.15, @import.calculate_tax(1)
  end
  def test_excempt_tax_one_dollar
    assert_equal 0, @excempt.calculate_tax(1)
  end
  def test_excmpt_import_one_dollar
    assert_equal 0.05, @excempt_import.calculate_tax(1)
  end
end
