class AutomationDriver
  attr_reader :driver

  def initialize(_driver)
    @driver = _driver
  end #initialize

  def send(*_args)
    start_time = Time.now
    while Time.now - start_time < 30
      ex = nil
      begin
        result = self.do_work *_args
      rescue StandardError => e
        ex = e
      end #rescue
      break if ex.nil?
    end #while
    raise ex unless ex.nil?
    result
  end #send

  protected
  #should be override by subclass
  def process_result(_result)

  end #process_result

  def do_work(*_args)
    if self.respond_to? _args[0]
      result = self.process_result super
    else
      result = self.process_result @driver.send *_args
    end #else
    result
  end
end #class automation_driver