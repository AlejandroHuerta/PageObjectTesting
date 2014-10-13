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
end #PageObject