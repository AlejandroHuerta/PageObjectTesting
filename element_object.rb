
class ElementObject
  attr_reader :driver, :name, :selector, :children, :actions, :next_page

  def initialize(_driver, _name, _selector, _children = nil, _actions = nil, _next_page = nil)
    @driver = _driver
    @name = _name
    @selector = _selector
    @children = [*_children] unless _children.nil?
    @actions = _actions.nil? ? [] : _actions
    @next_page = _next_page
  end #initialize

  def send(*_args)
    if @actions.include?(_args[0]) || @actions.include?(_args[0].class)
      self.do_work *_args
    elsif @children.length > 0
      found_child = get_child_name _args[0]
      if found_child.nil?
        @children.each do |child|
          child.set_driver self.driver.send self.selector.type, self.selector.locator
          child.send *_args
        end #do
      else
        found_child.set_driver self.driver.send self.selector.type, self.selector.locator
        return found_child
      end #else
    elsif @driver.respond_to? _args[0]
      @driver.send *_args
    else
      super
    end #else
  end #send

  def do_work(*_args)
    native_element = self.driver.send(self.selector.type, self.selector.locator)

    result = self.action native_element, *_args

    if @next_page.nil?
      result
    else
      @next_page
    end #else
  end #do_work

  #overridden by subclass
  def action(_driver, *_args)

  end #action

  protected
  def set_driver(_driver)
    @driver = _driver
  end #set_driver

  def get_child_name(_name)
    child = nil
    @children.each do |c|
      child = c if c.name.downcase == _name.downcase
    end #do
    child
  end #get_child_name
end #class element_object

module PageObject
  def element(_name, _selector, _children = nil)
    ElementObject.new @driver, _name, _selector, _children
  end
end