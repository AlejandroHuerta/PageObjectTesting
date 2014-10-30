require_relative '../elements/element_object'
require_relative '../elements/click_element'
require_relative '../elements/text_input_element'
require_relative '../elements/list_element'
require_relative '../elements/selector'
require_relative '../elements/checkbox_element'
require_relative '../elements/save_element'

module PageObject

  def create_element(hash)
    create_element_object :element, hash
  end

  def create_click_object(hash)
    create_element_object :click_object,  hash
  end

  def create_text_field( hash)
    create_element_object :text_field, hash
  end

  def create_list(hash)
    create_element_object :list, hash
  end

  def create_checkbox(hash)
    create_element_object :checkbox_object, hash
  end

  def create_save(hash)
    create_element_object :save_element, hash
  end

  protected
  def create_element_object(element, hash)
    raise ArgumentError, 'Argument not a hash' unless hash.instance_of? Hash
    @params[:children][hash[:name]] = self.send(element, hash)
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