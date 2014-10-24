require_relative 'automation_driver'
require 'watir'
require_relative '../../lib/page_object/page_object'

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

module PageObject
  #Action filters for this driver
  ElementObject.actions_dictionary = {see: :present?}
  TextInputElement.actions_dictionary = {enter: :value, text: :value}
  CheckboxElement.actions_dictionary = {check: :set, uncheck: :clear, checked?: :set?}
end #page_object