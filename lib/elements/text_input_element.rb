require_relative 'element_object'

class TextInputElement < ElementObject
  def get_actions
    {:enter => :enter, :set => :set, :text => :text, :value => :value}
  end
end #class text_input_object

module PageObject
  def text_field(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    TextInputElement.new hash
  end#text_field
end#PageObject