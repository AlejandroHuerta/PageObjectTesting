require_relative '../Support/class_level_inheritable_attributes'

module PageObject
  class ElementObject
    include ClassLevelInheritableAttributes

    inheritable_attributes :actions_dictionary
    @actions_dictionary = {}

    attr_reader :params

    def initialize(hash)
      #we keep the hash passed in to allow for easier extendability
      @params = hash
      raise ArgumentError.new 'No driver passed' unless @params.has_key? :driver
      raise ArgumentError.new 'No name given' unless @params.has_key? :name
      @params[:selector] = @params.has_key?(:selector) ? [*@params[:selector]] : []
      @params[:children] = @params.has_key?(:children) ? [*@params[:children]] : []

      #merging actions together
      if @params.has_key? :actions
        @params[:actions] = @params[:actions].merge({:see => :see}){|_key, oldval, _newval| oldval}
      else
        @params[:actions] = {:see => :see}
      end#else

      @params[:actions].merge!(ElementObject.actions_dictionary){|_key, _oldval, newval| newval}
      @params[:actions].merge!(self.class.actions_dictionary){|_key, _oldval, newval| newval}
    end #initialize

    #checks if the incoming method call is something we can handle. otherwise it sends it to our super class
    def send(*args)
      #let's check if we respond to this action
      if @params[:actions].has_key?(args[0]) || @params[:actions].has_key?(:all)
        self.do_work *args
      #is this an class type of action such as Fixnum?
      elsif @params[:actions].has_key? args[0].class
        args.unshift(args[0].class.to_s)
        self.do_work *args
      #we don't respond to this action or it's a child's name
      elsif @params[:children].length > 0
        found_child = get_child_name args[0]
        #Did we find the child? if not it's probably an action for one of them
        if found_child.nil?
          #go through all the children until we find one that responds to the action
          @params[:children].each do |child|
            next unless child.params[:actions].has_key? args[0]
            child.set_driver self.get_native_element
            return child.send *args
          end #do
        #we found a child with the name given
        else
          #set the driver of the child
          found_child.set_driver self.get_native_element
          return found_child
        end #else
      #it was neither an action we respond to nor a child's name perhaps our driver will accept
      elsif @params[:driver].respond_to? args[0]
        @params[:driver].send *args
      #last resort, it must be a method for our super class
      else
        super
      end #else
    end #send

    #begings the process of calling the action onto the driver by first using selectors
    def do_work(*args)
      #lets get our driver element with our selectors
      native_element = self.get_native_element

      #do we have a defined method for this call?
      #otherwise construct the default send
      if self.respond_to? args[0]
        self.__send__ args.shift, native_element, *args
      else
        native_element.send @params[:actions][args.shift.to_sym], *args
      end#else
    end #do_work

    protected
    def set_driver(driver)
      @params[:driver] = driver
    end #set_driver

    #goes through our children to see if the call matches a name
    def get_child_name(name)
      child = nil
      @params[:children].each do |c|
        child = c if c.params[:name].downcase == name.downcase
      end #do
      child
    end #get_child_name

    #goes through the selectors and generates the driver element
    def get_native_element
      native_element = @params[:driver]

      unless @params[:selector].empty?
        @params[:selector].each do |selector|
          #if locator is nil it's probably a call that doesn't take any other arguments
          if selector.locator.nil?
            native_element = native_element.send selector.type
          else
            native_element = native_element.send selector.type, selector.locator
          end#else
        end#do
      end#unless
      native_element
    end#get_native_element
  end #class element_object

  #helper method for creating an element
  def element(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    ElementObject.new  hash
  end #element
end #PageObject