require_relative 'automation_driver'
require 'watir'

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
    end #unless
  end #process_result

  def check
    @driver.send :set
  end

  def uncheck
    @driver.send :clear
  end
end