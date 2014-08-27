require_relative 'element_object'

class ListElement < ElementObject
  def initialize(_driver, _name, _hash)
    _hash[:actions] = Fixnum
    super
  end #initialize

  def action(_driver, args)
    if args[0].is_a? Fixnum
      @children.each do |child|
        child.selector.locator[:index] = args[0]
      end #do
    end #if
    self
  end #action
end #class list_object

module PageObject
  def list(_name, _hash = {})
    ListElement.new @driver, _name, _hash
  end
end