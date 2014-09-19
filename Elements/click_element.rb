require_relative 'element_object'

class ClickElement < ElementObject
  def initialize(_driver, _name, _hash)
    _hash[:method] = :click if _hash[:method].nil?
    _hash[:actions] = :click
    super
  end #initialize
end #click_object

module PageObject
  def click_object(_name, _hash = {})
    ClickElement.new @driver, _name, _hash
  end
end