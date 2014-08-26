require_relative 'automation_driver'
require 'watir'

class WatirDriver < AutomationDriver
  def initialize(_driver = nil)
    if _driver.nil?
      _driver = Watir::Browser.new :chrome
    end

    super _driver
  end #initiliaze

  def send(*_args)
    _args[0] = self.__send__ _args[0] if self.respond_to? _args[0]
    super
  end

  def process_result(_result)
    if _result.class.name.split('::').first == 'Watir'
      WatirDriver.new _result
    else
      _result
    end #else
  end #process_result

  def check
    :set
  end #check

  def uncheck
    :clear
  end #uncheck

  def checked?
    :set?
  end #checked?
end