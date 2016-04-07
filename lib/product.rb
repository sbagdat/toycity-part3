class Product
  @@products = []
  attr_reader :title

  def initialize(options={})
  	@title = options[:title]
  	add_to_products
  end

  def self.all
    @@products
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