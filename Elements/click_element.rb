require_relative 'element_object'

module PageObject
  class ClickElement < ElementObject
    def initialize(_hash)
      if _hash[:actions].nil?
        _hash[:actions] = {:click => :click}
      else
        _hash[:actions].merge!({:click => :click}){|key, oldval, newval| oldval}
      end
      super
    end #initialize
  end #click_object


  def click_object(_hash)
    _hash[:driver] = @driver unless _hash.has_key? :driver
    ClickElement.new _hash
  end
end