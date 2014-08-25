require_relative 'element_object'

class ClickObject < ElementObject
  def initialize(_driver, _name, _selector, _children = nil)
    super _driver, _name, _selector, _children, [:click]
  end #initialize

  def action(_driver, *_args)
    _driver.send :click
  end #action
end #click_object

module PageObject
  def click_object(_name, _selector, _children = nil)
    ClickObject.new @driver, _name, _selector, _children
  end
end