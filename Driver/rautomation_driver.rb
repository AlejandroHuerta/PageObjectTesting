require_relative 'automation_driver'
require 'rautomation'

class RAutomationDriver < AutomationDriver
  def initialize(driver)
    super driver
  end #initiliaze

  def process_result(result)
    result
  end #process_result
end

module PageObject
  #Action filters for this driver
  ElementObject.actions_dictionary = {see: :exists?}

  require_relative '../Elements/click_element'
  class ClickElement
    def click(driver, *args)
      driver.send(@params[:actions][:click], *args){true}
    end
  end
end #PageObject