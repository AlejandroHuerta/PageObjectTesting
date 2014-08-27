require_relative 'element_object'

class CheckboxElement < ElementObject
  def initialize(_driver, _name, _hash)
    _hash[:actions] = [:check, :uncheck, :set, :clear, :checked?, :set?]
    super
  end#initialize

  def action(_driver, *_args)
    _driver.send _args[0]
  end#action
end#CheckboxObject

module PageObject
  def checkbox_object(_name, _hash = {})
    CheckboxElement.new @driver, _name, _hash
  end
end