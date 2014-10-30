require 'singleton'
require_relative '../page'

module PageObject
  class PageBuilder
    include Singleton

    attr_reader :stack, :factories

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
      create_element Elements::ElementObject, name, &block
    end#element

    def actions(hash)
      @stack.last[:actions] ||= {}
      @stack.last[:actions].merge!(hash) {|_key, _oldval, newval| newval}
    end#actions

    def click(name, &block)
      create_element Elements::ClickElement, name, &block
    end#click

    def checkbox(name, &block)
      create_element Elements::CheckboxElement, name, &block
    end#checkbox

    def list(name, &block)
      create_element Elements::ListElement, name, &block
    end#list

    def save(name, &block)
      create_element Elements::SaveElement, name, &block
    end#save

    def text(name, &block)
      create_element Elements::TextInputElement, name, &block
    end#text_input

    def next_page(name)
      @stack.last[:next_page] = name
    end#next_page

    def check(hash)
      method_value = hash.shift
      @stack.last[:before] = proc {|driver| driver.send(method_value[0]).match method_value[1]}
    end

    def add_factory(method, klass)
      @factories ||= {}
      @factories[method] = klass
    end#add_factory

    def method_missing(method, *args)
      if @factories.include? method
        @factories[method].define *args
      else
        super
      end#else
    end#method_missing

    private
    def create_element(klass, name, &block)
      #add our hash that will be possibly filled with values by further calls
      @stack.push name: name
      #run our block if given
      instance_eval &block if block_given?

      #elements expect an array not hash
      hash = @stack.pop
      hash[:children] = hash[:children].nil? ? {} : hash[:children].values

      #create the element and add it to the stacks top element's children array
      this = Object::const_get(klass.name).new hash
      @stack.last[:children] ||= {}
      @stack.last[:children][name] = this
    end#create_element
  end#PageBuilder

  class Selector
    class << self

      def define(*args, &block)
        #run the block given
        if block_given?
          instance_eval &block
        else
          PageBuilder.instance.stack.last[:selector] ||= []
          PageBuilder.instance.stack.last[:selector].push Elements::Selector.new *args
        end#else
      end#define
    end#class << self
  end#Selector

  PageBuilder.instance.add_factory :selector, Selector

end#PageObject