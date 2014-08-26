require_relative '../Elements/element_object'
require_relative '../Elements/click_element'
require_relative '../Elements/text_input_element'
require_relative '../Elements/list_element'
require_relative '../Elements/selector'
require_relative '../Elements/checkbox_element'

module PageObject
  attr_accessor :driver
  attr_reader :elements

  def initialize(_driver)
    @driver = _driver
    @elements = {}
  end #initialize

  def send(*_args)
    if @elements.has_key? _args[0]
      @elements[_args[0]]
    else
      super
    end #else
  end #send

  def method_missing(_method_name, *_args, &_block)
    if @driver.respond_to? _method_name
      @driver.send _method_name, *_args, &_block
    else
      super
    end #else
  end #method_missing

  def selector(_type, _locator)
    Selector.new(_type, _locator)
  end

  def create_element(_name, _selector, _children = nil)
    @elements[_name] = element _name, _selector, _children
  end

  def create_click_object(_name, _selector, _children = nil)
    @elements[_name] = click_object  _name, _selector, _children
  end

  def create_text_field(_name, _selector, _children = nil)
    @elements[_name] = text_field _name, _selector, _children
  end

  def create_list(_name, _selector, _children)
    @elements[_name] = list _name, _selector, _children
  end

  def create_checkbox(_name, _selector, _children = nil)
    @elements[_name] = checkbox_object _name, _selector, _children
  end
end #module page_object