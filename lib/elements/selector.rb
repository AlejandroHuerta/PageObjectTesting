module Elements
  class Selector
    attr_accessor :type, :specifier

    def initialize(hash = {})
      raise ArgumentError unless hash.is_a? Hash
      @type = hash.delete(:type) { :element }
      @specifier = hash[:specifier]
    end #initialize
  end #class selector
end#Elements

module PageObject
  def selector_object(hash)
    Elements::Selector.new hash
  end#selector
end#page_object