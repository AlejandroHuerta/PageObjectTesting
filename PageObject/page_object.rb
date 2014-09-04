require_relative '../Elements/element_object'
require_relative '../Elements/click_element'
require_relative '../Elements/text_input_element'
require_relative '../Elements/list_element'
require_relative '../Elements/selector'
require_relative '../Elements/checkbox_element'
require_relative '../Elements/save_element'

module PageObject

  def create_element(_name, _hash = {})
    create_element_object :element, _name, _hash
  end

  def create_click_object(_name, _hash = {})
    create_element_object :click_object, _name, _hash
  end

  def create_text_field(_name, _hash = {})
    create_element_object :text_field, _name, _hash
  end

  def create_list(_name, _hash = {})
    create_element_object :list, _name, _hash
  end

  def create_checkbox(_name, _hash = {})
    create_element_object :checkbox_object, _name, _hash
  end

  def create_save(_name, _hash = {})
    create_element_object :save_element, _name, _hash
  end

  protected
  def create_element_object(_element, _name, _hash)
    raise ArgumentError, 'Argument non a hash' unless _hash.instance_of? Hash
    @elements[_name] = self.send(_element, _name, _hash)
  end
end #module page_object