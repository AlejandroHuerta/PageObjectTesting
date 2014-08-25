require_relative 'element_object'

class CheckboxObject < ElementObject
  def initialize(_driver, _name, _selector, _children = nil)
    super _driver, _name, _selector, _children, [:check, :uncheck]
  end#initialize

  def action(_driver, *_args)
    _driver.send _args[0]
  end#action
end#CheckboxObject

module PageObject
  def checkbox_object(_name, _selector, _children = nil)
    CheckboxObject.new @driver, _name, _selector, _children
  end
end