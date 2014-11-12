require_relative 'page_builder'
require_relative '../../../lib/elements/element_object'

module PageObject
  module PageBuilder
    class ElementBuilder
      class << self
        def element(name, &block)
          create_element ElementObject, name, &block
        end#element

        def method_missing(method, *args, &block)
          PageBuilder.send method, *args, &block
        end#method_missing

        private
        def create_element(klass, name, &block)
          #add our hash that will be possibly filled with values by further calls
          PageBuilder.stack.push name: name
          #run our block if given
          instance_eval &block if block_given?

          #elements expect an array not hash
          hash = PageBuilder.stack.pop
          hash[:children] ||= {}
          children = hash[:children]
          hash[:children] = []
          children.each do |_key, child|
            hash[:children].push child
          end#each

          #create the element and add it to the stacks top element's children array
          this = Object::const_get(klass.name).new hash
          PageBuilder.stack.last[:children] ||= {}
          PageBuilder.stack.last[:children][name] = this
        end#create_element
      end#class << self
    end#ElementBuilder

    PageBuilder.factories[:element] = ElementBuilder
  end#PageBuilder
end#PageObject