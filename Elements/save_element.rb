require_relative 'element_object'

module PageObject
  class SaveElement < ElementObject
    def initialize(_hash)
      #were any override actions passed in?
      if _hash[:actions].nil?
        _hash[:actions] = {:save => :save, :value => :value}
      #overrides or additions passed in, let's merge them
      else
        _hash[:actions].merge!({:save => :save, :value => :value}){|key, oldval, newval| oldval}
      end#else
      super
    end #initialize

    #assigns the value returned into @value using the save method assigned
    def save(_driver, *_args)
      @value = _driver.send @params[:actions][:save], *_args
    end#save

    #returns the value that was stored in save
    def value(_driver, *_args)
      @value
    end#value
  end #SaveElement

  #helper method to create a SaveElement
  def save_element(_hash)
    _hash[:driver] = @driver unless _hash.has_key? :driver
    SaveElement.new _hash
  end #save_element
end #PageObject