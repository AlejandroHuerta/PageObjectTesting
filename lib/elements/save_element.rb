require_relative 'element_object'

class SaveElement < ElementObject
  def initialize(hash)
    #were any override actions passed in?
    if hash[:actions].nil?
      hash[:actions] = {:save => :save, :value => :value}
    #overrides or additions passed in, let's merge them
    else
      hash[:actions].merge!({:save => :save, :value => :value}){|_key, oldval, _newval| oldval}
    end#else
    super
  end #initialize

  #assigns the value returned into @value using the save method assigned
  def save(driver, *args)
    @value = driver.send @params[:actions][:save], *args
  end#save

  #returns the value that was stored in save
  def value(_driver, *_args)
    @value
  end#value
end #SaveElement

module PageObject
  #helper method to create a SaveElement
  def save_element(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    SaveElement.new hash
  end #save_element
end #page_object