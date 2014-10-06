require_relative 'element_object'

module PageObject
  class SaveElement < ElementObject
    def initialize(_hash)
      if _hash[:actions].nil?
        _hash[:actions] = {:save => :save, :value => :value}
      else
        _hash[:actions].merge!({:save => :save, :value => :value}){|key, oldval, newval| oldval}
      end
      super
    end #initialize

    def save(_driver, *_args)
      @value = _driver.send @actions[:save], *_args
    end#save

    def value(_driver, *_args)
      @value
    end#value
  end #SaveElement

  def save_element(_hash)
    _hash[:driver] = @driver unless _hash.has_key? :driver
    SaveElement.new _hash
  end #save_element
end #PageObject