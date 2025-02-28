class Product
  @@products = []
  attr_reader :title, :price, :stock, :transactions

  def initialize(options={})
  	@title = options[:title] || (raise MissingArgumentError, 'Product object cannot be untitled.')
  	@price = options[:price] || (raise MissingArgumentError, 'Product object must have a prices.')
  	@stock = options[:stock] || (raise MissingArgumentError, 'You must provide a stock value for the product object.')
    @transactions = []
  	add_to_products
  end

  def in_stock?
  	@stock > 0
  end

  def sell
    if in_stock?
      @stock -= 1
    else
      raise OutOfStockError, "'#{@title}' is out of stock."
    end
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

  def self.all
    @@products
  end

  def self.find_by_title(product_title)
    Finder.find_in @@products, title: product_title
  end

  def self.in_stock
  	@@products.select {|product| product.in_stock? }
  end

  private

  def add_to_products
  	raise DuplicateProductError, "#{@title} already exists." if exist?
  	@@products << self
  end

  def exist?
    @@products.any? { |p| p.title == @title }
  end
end
