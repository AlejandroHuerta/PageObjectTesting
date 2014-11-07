require_relative 'element_object'

class ClickElement < ElementObject
  def get_actions
    {:click => :click}
  end
end #click_object

module PageObject
  def click_object(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    ClickElement.new hash
  end#click_object
end#PageObject