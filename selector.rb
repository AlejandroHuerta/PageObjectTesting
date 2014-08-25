class Selector
  attr_accessor :type, :locator

  def initialize(_type, _locator)
    @type = _type
    @locator = _locator
  end #initialize
end #class selector