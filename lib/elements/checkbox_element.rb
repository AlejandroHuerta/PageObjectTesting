require_relative 'element_object'

module PageObject
  class CheckboxElement < ElementObject
    def initialize(_hash)
      if _hash[:actions].nil?
        _hash[:actions] = {:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}
      else
        _hash[:actions].merge!({:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}){|key, oldval, newval| oldval}
      end
      super
    end#initialize
  end#CheckboxObject

  def checkbox_object(_hash)
    _hash[:driver] = @driver unless _hash.has_key? :driver
    CheckboxElement.new _hash
  end
end