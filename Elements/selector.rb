
module PageObject
  class Selector
    attr_accessor :type, :locator

    def initialize(_hash = {})
      raise ArgumentError unless _hash.is_a? Hash
      @type = _hash.delete(:type) { :element }
      @locator = _hash.has_key?(:locator) ? _hash[:locator] : {}
    end #initialize
  end #class selector

  def selector(_hash)
    Selector.new _hash
  end#selector
end#PageObject