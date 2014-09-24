require_relative 'element_object'

class ListElement < ElementObject
  def initialize(_driver, _name, _hash)
    if _hash[:actions].nil?
      _hash[:actions] = {Fixnum => Fixnum}
    else
      _hash[:actions].merge!({Fixnum => Fixnum}){|key, oldval, newval| oldval}
    end
    super
  end #initialize

  def Fixnum(_driver, *_args)
    if _args[0].is_a? Fixnum
      @children.each do |child|
        child.selector.locator[:index] = _args[0]
      end #do
    end #if
    self
  end
end #class list_object

module PageObject
  def list(_name, _hash = {})
    ListElement.new @driver, _name, _hash
  end
end