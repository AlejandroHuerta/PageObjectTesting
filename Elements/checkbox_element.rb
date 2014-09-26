require_relative 'element_object'

module PageObject
  class CheckboxElement < ElementObject
    def initialize(_driver, _name, _hash)
      if _hash[:actions].nil?
        _hash[:actions] = {:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}
      else
        _hash[:actions].merge!({:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}){|key, oldval, newval| oldval}
      end
      super
    end#initialize
  end#CheckboxObject

  def checkbox_object(_name, _hash = {})
    CheckboxElement.new @driver, _name, _hash
  end
end