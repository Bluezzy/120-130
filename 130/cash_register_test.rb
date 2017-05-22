require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @cash_register = CashRegister.new(2000)
    @transaction1 = Transaction.new(150)
    @transaction1.amount_paid = 200
  end

  def test_accept_money
    previous_amount = @cash_register.total_money
    current_amount = @cash_register.accept_money(@transaction1)
    assert_equal(previous_amount + 200, current_amount)
  end

  def test_change
    assert_equal(50, @cash_register.change(@transaction1))
  end

  def test_receipt
    a = puts "You've paid $150."
    assert_output("You've paid $#{@transaction1.item_cost}.\n") do
      @cash_register.give_receipt(@transaction1)
    end
  end

  def test_prompt_for_payment
    input = StringIO.new('150\n')
    @transaction1.prompt_for_payment(input: input)
    assert_equal 150, @transaction1.amount_paid
  end
end