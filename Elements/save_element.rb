require_relative 'element_object'

class SaveElement < ElementObject
  attr_reader :value

  def initialize(_driver, _name, _hash)
    _hash[:actions] = [:save, :value]
    @method = _hash[:method]
    super
  end #initialize

  def action(_driver, *_args)
    @value = _driver.send @method
  end #action
end #SaveElement

module PageObject
  def save_element(_name, _hash = {})
    SaveElement.new @driver, _name, _hash
  end #save_element
end #PageObject