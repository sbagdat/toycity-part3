class Transaction
  @@id = 1
  @@transactions = []
  attr_reader :customer, :product, :id

  def initialize(customer, product)
    @customer = customer
    @product = product
    p @product
    assign_id
    add_transaction
    update_stock
  end

  def add_transaction
    @@transactions << self
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.each do |transaction|
      return transaction if transaction.id == id
    end
    nil
  end

  private

  def assign_id
    @id = @@id
    increase_id_counter
  end

  def increase_id_counter
    @@id += 1
  end

  def update_stock
    @product.sell
  end
end
