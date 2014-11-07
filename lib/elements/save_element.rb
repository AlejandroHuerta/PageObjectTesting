require_relative 'element_object'

class SaveElement < ElementObject
  def get_actions
    {:save => :save, :value => :value}
  end

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