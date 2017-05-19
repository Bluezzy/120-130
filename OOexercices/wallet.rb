class Wallet
  def initialize
    @total = 0
  end

  def add(amount)
    @total += amount
  end

  private

  # Below the private keyword, methods can only be accessed from within the class.

  attr_reader :total #We create a getter method , an instance method that allow access to instance variable.

end

wallet = Wallet.new

wallet.add(30)
wallet.add(40)
puts wallet.total