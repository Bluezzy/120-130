class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Ben is right : on line 9, we're calling the getter method defined on line 2
# by attr_reader :balance, which returns the value contained in @balance,
# initialized on line 5.

my_bank_account = BankAccount.new(50)
puts my_bank_account.positive_balance? # => true

your_bank_account = BankAccount.new(-50)
puts your_bank_account.positive_balance? # => false  

class InvoiceEntry
  attr_reader :product_name
  attr_writer :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end
  
  def get_seven
    update_quantity(7)
  end
  
  private
  
  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end

object = InvoiceEntry.new("Book", 3)
puts object.inspect
object.get_seven
puts object.inspect