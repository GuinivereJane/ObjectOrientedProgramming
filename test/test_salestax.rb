require 'minitest/autorun'
require 'minitest/pride'
require './salestax'

class TestSalestax < MiniTest::Test

  def setup
    @item_imported_excempt = Item.new('pills',true)
    @item_excempt = Item.new('cow parts', false)
    @item_imported = Item.new('cow parts', true)
    @item = Item.new('muffler', false)
    @taxable = Tax.new(false)
    @excempt = Tax.new(true)
    @import = Import_Tax.new(false)
    @excempt_import = Import_Tax.new(true)
  end

  def test_add_excemption
    Item.add_excemption 'medicine'
    assert_equal ['books', 'food', 'medical products', 'medicine'], Item.return_excemptions
  end

  def test_end_excemption
    Item.end_excemption 'medicine'
    assert_equal ['books', 'food', 'medical products'], Item.return_excemptions
  end
  def test_imported_tax_rate
    assert_equal 0.15, @item_imported.tax.tax_rate.round(2)
  end
  def test_excempt_imported_tax_rate
    assert_equal 0.05, @item_imported_excempt.tax.tax_rate.round(2)
  end
  def test_excempt_tax_rate
    assert_equal 0, @item_excempt.tax.tax_rate.round(2)
  end
  def test_tax_rate
    assert_equal 0.1, @item.tax.tax_rate.round(2)
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
