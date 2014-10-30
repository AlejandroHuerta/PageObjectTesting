require_relative 'element_object'

class ClickElement < ElementObject
  def initialize(hash)
    if hash[:actions].nil?
      hash[:actions] = {:click => :click}
    else
      hash[:actions].merge!({:click => :click}){|_key, oldval, _newval| oldval}
    end
    super
  end #initialize
end #click_object

module PageObject
  def click_object(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    ClickElement.new hash
  end#click_object
end#PageObject