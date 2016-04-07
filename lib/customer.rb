class Customer
  @@customers = []

  attr_reader :name, :transactions

  def initialize(options = {})
    @name = options[:name] || 'No name'
    @transactions = []
    add_to_customers
  end

  def purchase(product)
    Transaction.new(self, Product.find_by_title(product.title))
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  def self.all
    @@customers
  end

  def self.find_by_name(customer_name)
    Finder.find_in @@customers, name: customer_name
  end

  private

  def exist?
    @@customers.any? { |c| c.name == @name }
  end

  def add_to_customers
    raise DuplicateProductError, "#{@name} already exists." if exist?
    @@customers << self
  end
end
