require_relative 'element_object'

module PageObject
  class TextInputElement < ElementObject
    def initialize(_hash)
      if _hash[:actions].nil?
        _hash[:actions] = {:enter => :enter, :set => :set, :text => :text, :value => :value}
      else
        _hash[:actions].merge!({:enter => :enter, :set => :set, :text => :text, :value => :value}){|key, oldval, newval| oldval}
      end
      super
    end #initialize
  end #class text_input_object

  def text_field(_hash)
    _hash[:driver] = @driver unless _hash.has_key? :driver
    TextInputElement.new _hash
  end
end