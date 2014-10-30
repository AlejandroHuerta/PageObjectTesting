require_relative 'page_builder'

module PageObject
  module PageBuilder
    class Selector
      class << self

        def define(*args, &block)
          #run the block given
          if block_given?
            instance_eval &block
          else
            PageBuilder.stack.last[:selector] ||= []
            PageBuilder.stack.last[:selector].push Elements::Selector.new *args
          end#else
        end#define
      end#class << self
    end#Selector

    PageBuilder.add_factory :selector, Selector
  end
end