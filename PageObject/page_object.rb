require_relative '../Elements/element_object'
require_relative '../Elements/click_element'
require_relative '../Elements/text_input_element'
require_relative '../Elements/list_element'
require_relative '../Elements/selector'
require_relative '../Elements/checkbox_element'
require_relative '../Elements/save_element'

module PageObject

  def create_element(_hash)
    create_element_object :element, _hash
  end

  def create_click_object(_hash)
    create_element_object :click_object,  _hash
  end

  def create_text_field( _hash)
    create_element_object :text_field, _hash
  end

  def create_list(_hash)
    create_element_object :list, _hash
  end

  def create_checkbox(_hash)
    create_element_object :checkbox_object, _hash
  end

  def create_save(_hash)
    create_element_object :save_element, _hash
  end

  protected
  def create_element_object(_element, _hash)
    raise ArgumentError, 'Argument not a hash' unless _hash.instance_of? Hash
    @elements[_hash[:name]] = self.send(_element, _hash)
  end
end #module page_object