require_relative 'element_object'

class ListObject < ElementObject
  def initialize(_driver, _name, _selector, _children)
    super _driver, _name, _selector, _children, [Fixnum]
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
  def list(_name, _selector, _children)
    ListObject.new @driver, _name, _selector, _children
  end
end