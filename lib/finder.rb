class Finder
  def self.find_in(items, options = {})
    attribute = options.first[0]
    value     = options.first[1]

    items.each { |item| return item if item.public_send(attribute) == value }
    nil # not found
  end
end
