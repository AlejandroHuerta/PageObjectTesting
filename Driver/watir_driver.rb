require_relative 'automation_driver'
require 'watir'
require_relative '../PageObject/page_object'

class WatirDriver < AutomationDriver
  def initialize(_driver = nil)
    if _driver.nil?
      _driver = Watir::Browser.new :chrome
    end

    super _driver
  end #initiliaze

  def process_result(_result)
    if _result.class.name.split('::').first == 'Watir'
      WatirDriver.new _result
    else
      _result
    end #else
  end #process_result

  def on_mouse_down
    @driver.fire_event 'onmousedown'
  end
end# WatirDriver

module PageObject
  #Action filters for this driver
  ElementObject.actions_dictionary = {see: :present?}
  TextInputElement.actions_dictionary = {enter: :value, text: :value}
  CheckboxElement.actions_dictionary = {check: :set, uncheck: :clear, checked?: :set?}
end #PageObject