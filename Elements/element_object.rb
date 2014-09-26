require_relative '../Support/class_level_inheritable_attributes'

module PageObject
  class ElementObject
    include ClassLevelInheritableAttributes

    inheritable_attributes :actions_dictionary
    @actions_dictionary = {}

    attr_reader :driver, :name, :selector, :children, :actions, :next_page

    def initialize(_driver, _name, _hash)
      @driver = _driver
      @name = _name
      @selector = _hash[:selector]
      @children = []
      @children = [*_hash[:children]] if _hash.has_key? :children
      @next_page = _hash[:next_page]

      #merging actions together
      if _hash[:actions].nil?
        @actions = {:see => :see}
      else
        @actions = _hash[:actions].merge({:see => :see}){|key, oldval, newval| oldval}
      end#else

      @actions.merge!(ElementObject.actions_dictionary){|key, oldval, newval| newval}
      @actions.merge!(self.class.actions_dictionary){|key, oldval, newval| newval}
    end #initialize

    def send(*_args)
      if @actions.has_key?(_args[0]) || @actions.has_key?(:all)
        self.do_work *_args
      elsif @actions.has_key? _args[0].class
        _args.unshift(_args[0].class.to_s)
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
      native_element = @selector.nil? ? @driver : @driver.send(self.selector.type, self.selector.locator)

      #do we have a defined method for this call?
      #otherwise construct the default send
      if self.respond_to? _args[0]
        result = self.__send__ _args.shift, native_element, *_args
      else
        result = native_element.send @actions[_args.shift.to_sym], *_args
      end

      #if we have a next_page specified we generate it and assign it
      if @next_page.nil?
        result
      else
        Page.page = Page.build_page(@next_page)
      end #else
    end #do_work

    def see(_driver, *_args)
      _driver.send @actions[:see], *_args
    end#see

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

  def element(_name, _hash = {})
    ElementObject.new @driver, _name, _hash
  end #element
end #PageObject