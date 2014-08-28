require_relative '../Support/class_level_inheritable_attributes'

class ElementObject
  include ClassLevelInheritableAttributes

  inheritable_attributes :actions_dictionary
  @actions_dictionary = {}

  attr_reader :driver, :name, :selector, :children, :actions, :next_page

  def initialize(_driver, _name, _hash)
    @driver = _driver
    @name = _name
    @selector = _hash[:selector]
    @children = [*_hash[:children]] if _hash.has_key? :children
    @actions = (_hash.has_key?(:actions) ? [*_hash[:actions]] : [])
    @next_page = _hash[:next_page]
  end #initialize

  def send(*_args)
    if @actions.include?(_args[0]) || @actions.include?(_args[0].class) || @actions.include?(:all)
      self.do_work *_args
    elsif !@children.nil? && @children.length > 0
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
    if self.respond_to? *_args[0].to_s
      result = self.__send__ *_args
    else
      native_element = @selector.nil? ? @driver : @driver.send(self.selector.type, self.selector.locator)
      result = self.action native_element, *filter_actions(*_args)
    end #else

    if @next_page.nil?
      result
    else
      @next_page
    end #else
  end #do_work

  #overridden by subclass
  def action(_driver, *_args)
    raise NotImplementedError, new("#{self.class.name} is an abstract class.")
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

  def filter_actions(*_args)
    _args[0] = self.class.actions_dictionary[_args[0]] if self.class.actions_dictionary.has_key? _args[0]
    _args
  end #filter_actions
end #class element_object

module PageObject
  def element(_name, _hash = {})
    ElementObject.new @driver, _name, _hash
  end #element
end #PageObject