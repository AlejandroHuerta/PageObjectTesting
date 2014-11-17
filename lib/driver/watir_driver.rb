require_relative 'automation_driver'
require 'watir'

class WatirDriver < AutomationDriver
  def initialize(_driver = nil)
    if _driver.nil?
      _driver = Watir::Browser.new :chrome
    end#if nil?

    super _driver
  end #initiliaze

  def process_result(_result)
    if _result.class.name.split('::').first == 'Watir'
      WatirDriver.new _result
    else
      _result
    end #else
  end #process_result

  def on_mouse_down(*_args)
    @driver.fire_event 'onmousedown'
  end#on_mouse_down

  def see_text_as(*_args)
    @driver.text == _args.shift
  end#see_text_as
end# WatirDriver

require_relative '../../lib/elements/element_object'
require_relative '../../lib/elements/text_input_element'
require_relative '../../lib/elements/checkbox_element'
require_relative '../../lib/elements/key_sequence_element'

#Action filters for this driver
ElementObject.actions_dictionary = {see: :present?}
TextInputElement.actions_dictionary = {enter: :value, text: :value}
CheckboxElement.actions_dictionary = {check: :set, uncheck: :clear, checked?: :set?}
KeySequenceElement.actions_dictionary = {do: :send_keys, enter: :send_keys}

require_relative '../../lib/elements/select_list_element'

class SelectListElement
  def options(driver, *_args)
    #we expect to be returned an Array of the text options
    #so we must take the result which is a WatirDriver wrapper, access the driver
    #which is a WatirCollection, request an array
    #and map the individual options so we can grab the text
    driver.send(params[:actions][:options]).driver.to_a.map {|option| option.text}
  end#options
end#SelectListElement