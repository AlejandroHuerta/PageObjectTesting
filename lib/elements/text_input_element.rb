require_relative 'element_object'

class TextInputElement < ElementObject
  def initialize(hash)
    if hash[:actions].nil?
      hash[:actions] = {:enter => :enter, :set => :set, :text => :text, :value => :value}
    else
      hash[:actions].merge!({:enter => :enter, :set => :set, :text => :text, :value => :value}){|_key, oldval, _newval| oldval}
    end#else
    super
  end #initialize
end #class text_input_object

module PageObject
  def text_field(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    TextInputElement.new hash
  end#text_field
end#PageObject