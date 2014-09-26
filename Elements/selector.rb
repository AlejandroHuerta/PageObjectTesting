
module PageObject
  class Selector
    attr_accessor :type, :locator

    def initialize(_type, _locator = {})
      @type = _type
      @locator = _locator
    end #initialize
  end #class selector

  def selector(_type, _locator = {})
    Selector.new _type, _locator
  end#selector
end#PageObject