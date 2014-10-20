
module PageObject
  class Selector
    attr_accessor :type, :specifier

    def initialize(_hash = {})
      raise ArgumentError unless _hash.is_a? Hash
      @type = _hash.delete(:type) { :element }
      @specifier = _hash.has_key?(:specifier) ? _hash[:specifier] : {}
    end #initialize
  end #class selector

  def selector(_hash)
    Selector.new _hash
  end#selector
end#PageObject