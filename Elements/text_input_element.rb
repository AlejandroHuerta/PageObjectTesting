require_relative 'element_object'


class TextInputElement < ElementObject
  def initialize(_driver, _name, _hash)
    if _hash[:actions].nil?
      _hash[:actions] = {:enter => :enter, :set => :set, :text => :text, :value => :value}
    else
      _hash[:actions].merge!({:enter => :enter, :set => :set, :text => :text, :value => :value}){|key, oldval, newval| oldval}
    end
    super
  end #initialize
end #class text_input_object

module PageObject
  def text_field(_name, _hash)
    TextInputElement.new @driver, _name, _hash
  end
end