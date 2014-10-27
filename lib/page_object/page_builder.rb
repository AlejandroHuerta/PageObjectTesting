require_relative 'page'

module PageObject
  module PageBuilder
    class << self
      attr_reader :stack

      def define(&block)
        @stack ||= []
        @stack.push Page.new
        instance_eval &block if block_given?
        @stack.pop
      end#define

      def element(name, &block)
        create_element ElementObject, name, &block
      end#element

      def selector(hash)
        @stack.last.params[:selector].push Selector.new hash
      end#selector

      def actions(hash)
        @stack.last.params[:actions].merge!(hash) {|_key, _oldval, newval| newval}
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
        @stack.push Object::const_get(klass.name).new name: name
        instance_eval &block if block_given?
        this = @stack.pop
        @stack.last.params[:children][name] = this
      end#create_element
    end#class << self
  end#PageBuilder
end#PageObject