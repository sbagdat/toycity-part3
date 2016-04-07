class Transaction
  @@id = 1
  @@transactions = []
  attr_reader :customer, :product, :id

  def initialize(customer, product)
    @customer = customer
    @product = product
    assign_id
    add_transaction
    update_stock
  end

  def add_transaction
    @@transactions << self
    add_transaction_to_customer
    add_transaction_to_product
  end

  def add_transaction_to_customer
    @customer.add_transaction(self)
  end

  def add_transaction_to_product
    @product.add_transaction(self)
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    Finder.find_in @@transactions, id: id
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
