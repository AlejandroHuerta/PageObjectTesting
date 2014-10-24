require_relative 'automation_driver'
require 'rautomation'

class RAutomationDriver < AutomationDriver
  def initialize(driver)
    super driver
  end #initiliaze

  def process_result(result)
    result
  end #process_result
end#RAutomationDriver

module PageObject
  #Action filters for this driver
  ElementObject.actions_dictionary = {see: :exists?}

  require_relative '../Elements/click_element'
  class ClickElement
    #we define our click method because rautomation uses blocks to determine if a button click
    #was successful
    def click(driver, *args)
      #was a proc given as a :block parameter to this object? if not we create a default
      #block that always passes
      block = (@params[:block].nil? ? Proc.new {true} : @params[:block])
      driver.send(@params[:actions][:click], *args, &block)
    end#click
  end#ClickElement
end #page_object