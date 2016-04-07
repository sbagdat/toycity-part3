class Customer
  @@customers = []

  attr_reader :name

  def initialize(options = {})
    @name = options[:name] || 'No name'
    add_to_customers
  end

  def purchase(product)
    Transaction.new(self, Product.find_by_title(product.title))
  end

  def self.all
    @@customers
  end

  def self.find_by_name(customer_name)
    @@customers.each do |customer|
      return customer if customer.name == customer_name
    end
    nil # not found
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
