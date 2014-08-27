require_relative 'element_object'

class SaveElement < ElementObject
  attr_reader :value

  def initialize(_driver, _name, _hash)
    _hash[:actions] = :all
    super
  end #initialize

  def action(_driver, *_args)
    @value = _driver.send *_args
  end
end

module PageObject
  def save_element(_name, _hash = {})
    SaveElement.new @driver, _name, _hash
  end
end