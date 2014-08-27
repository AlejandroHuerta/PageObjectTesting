require_relative 'element_object'


class TextInputElement < ElementObject
  def initialize(_driver, _name, _hash)
    _hash[:actions] = [:enter, :set, :text]
    super
  end #initialize

  def action(_driver, *_args)
    _driver.send *_args
  end #action
end #class text_input_object

module PageObject
  def text_field(_name, _hash)
    TextInputElement.new @driver, _name, _hash
  end
end