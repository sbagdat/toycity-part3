class Product
  @@products = []
  attr_reader :title, :price, :stock

  def initialize(options={})
  	@title = options[:title] || 'untitled'
  	@price = options[:price] || 0.0
  	@stock = options[:stock] || 0
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

  def self.all
    @@products
  end

  def self.find_by_title(product_title)
  	@@products.each do |product|
  	  return product if product.title == product_title
  	end
  	nil # not found
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
