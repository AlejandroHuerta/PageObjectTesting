
module PageObject
  class Selector
    attr_accessor :type, :specifier

    def initialize(hash = {})
      raise ArgumentError unless hash.is_a? Hash
      @type = hash.delete(:type) { :element }
      @specifier = hash[:specifier]
    end #initialize
  end #class selector

  def selector(hash)
    Selector.new hash
  end#selector
end#page_object