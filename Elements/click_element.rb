require_relative 'element_object'

class ClickElement < ElementObject
  def initialize(_driver, _name, _hash)
    if _hash[:actions].nil?
      _hash[:actions] = {:click => :click}
    else
      _hash[:actions].merge!({:click => :click}){|key, oldval, newval| oldval}
    end
    super
  end #initialize

  def click(_driver, *_args)
    _driver.send @actions[:click], *_args
  end
end #click_object

module PageObject
  def click_object(_name, _hash = {})
    ClickElement.new @driver, _name, _hash
  end
end