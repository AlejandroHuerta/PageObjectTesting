require_relative 'page'

module PageObject
  module PageBuilder
    class << self
      attr_reader :stack

      def define(&block)
        #reset the stack
        @stack = []
        #place our hash
        @stack.push Hash.new
        #run the block given
        instance_eval &block if block_given?
        #take the top element and pass as the page's hash
        Page.new @stack.pop
      end#define

      def element(name, &block)
        create_element ElementObject, name, &block
      end#element

      def selector(hash)
        @stack.last[:selector] ||= []
        @stack.last[:selector].push Selector.new hash
      end#selector

      def actions(hash)
        @stack.last[:actions] ||= {}
        @stack.last[:actions].merge!(hash) {|_key, _oldval, newval| newval}
      end#actions

      def click(name, &block)
        create_element ClickElement, name, &block
      end#click

      def checkbox(name, &block)
        create_element CheckboxElement, name, &block
      end#checkbox

      def list(name, &block)
        create_element ListElement, name, &block
      end#list

      def save(name, &block)
        create_element SaveElement, name, &block
      end#save

      def text_input(name, &block)
        create_element TextInputElement, name, &block
      end#text_input

      private
      def create_element(klass, name, &block)
        #add our hash that will be possibly filled with values by further calls
        @stack.push name: name
        #run our block if given
        instance_eval &block if block_given?

        #elements expect an array not hash
        hash = @stack.pop
        hash[:children] ||= {}
        children = hash[:children]
        hash[:children] = []
        children.each do |_key, child|
          hash[:children].push child
        end#each

        #create the element and add it to the stacks top element's children array
        this = Object::const_get(klass.name).new hash
        @stack.last[:children] ||= {}
        @stack.last[:children][name] = this
      end#create_element
    end#class << self
  end#PageBuilder
end#PageObject