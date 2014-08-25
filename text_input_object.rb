require_relative 'element_object'


class TextInputObject < ElementObject
  def initialize(_driver, _name, _selector, _children = nil)
    super _driver, _name, _selector, _children, [:enter, :set]
  end #initialize

  def action(_driver, *_args)
    _driver.send :set, _args[1]
  end #action
end #class text_input_object

module PageObject
  def text_field(_name, _selector, _children = nil)
    TextInputObject.new @driver, _name, _selector, _children
  end
end