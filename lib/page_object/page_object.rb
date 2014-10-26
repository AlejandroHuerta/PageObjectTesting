require_relative '../elements/element_object'
require_relative '../elements/click_element'
require_relative '../elements/text_input_element'
require_relative '../elements/list_element'
require_relative '../elements/selector'
require_relative '../elements/checkbox_element'
require_relative '../elements/save_element'

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

class ElementObject
  def process_result(result)
    #if we have a next_page specified we generate it and assign it
    if @params[:next_page].nil?
      result
    else
      Page.page = Page.build_page(@params[:next_page])
    end #else
  end#process_result
end#ElementObject