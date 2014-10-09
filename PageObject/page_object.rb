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

  class ElementObject
    def do_work(*_args)
      #lets get our driver element with our selectors
      native_element = self.get_native_element

      #do we have a defined method for this call?
      #otherwise construct the default send
      if self.respond_to? _args[0]
        result = self.__send__ _args.shift, native_element, *_args
      else
        result = native_element.send @actions[_args.shift.to_sym], *_args
      end#else

      #if we have a next_page specified we generate it and assign it
      if @next_page.nil?
        result
      else
        Page.page = Page.build_page(@next_page)
      end #else
    end #do_work
  end#ElementObject

  protected
  def create_element_object(_element, _hash)
    raise ArgumentError, 'Argument not a hash' unless _hash.instance_of? Hash
    @elements[_hash[:name]] = self.send(_element, _hash)
  end
end #module page_object