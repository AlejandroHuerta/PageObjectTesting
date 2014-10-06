require_relative 'element_object'

module PageObject
  class ListElement < ElementObject
    def initialize(_hash)
      if _hash[:actions].nil?
        _hash[:actions] = {Fixnum => Fixnum}
      else
        _hash[:actions].merge!({Fixnum => Fixnum}){|key, oldval, newval| oldval}
      end#else
      super
    end #initialize

    def Fixnum(_driver, *_args)
      if _args[0].is_a? Fixnum
        @children.each do |child|
          child.selector[0].locator[:index] = _args[0]
        end #do
      end #if
      self
    end#Fixnum
  end #class list_object

  def list(_hash)
    _hash[:driver] = @driver unless _hash.has_key? :driver
    ListElement.new _hash
  end#list
end#PageObject