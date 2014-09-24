require_relative 'element_object'

class CheckboxElement < ElementObject
  def initialize(_driver, _name, _hash)
    if _hash[:actions].nil?
      _hash[:actions] = {:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}
    else
      _hash[:actions].merge!({:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}){|key, oldval, newval| oldval}
    end
    super
  end#initialize

  def check(_driver, *_args)
    _driver.send @actions[:check], *_args
  end

  def set(_driver, *_args)
    _driver.send @actions[:set], *_args
  end

  def clear(_driver, *_args)
    _driver.send @actions[:clear], *_args
  end

  def checked?(_driver, *_args)
    _driver.send @actions[:clear?], *_args
  end

  def set?(_driver, *_args)
    _driver.send @actions[:set?], *_args
  end
end#CheckboxObject

module PageObject
  def checkbox_object(_name, _hash = {})
    CheckboxElement.new @driver, _name, _hash
  end
end