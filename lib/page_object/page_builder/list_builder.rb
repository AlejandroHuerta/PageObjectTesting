require_relative 'page_builder'
require_relative '../../../lib/elements/list_element'
require_relative 'element_builder'

module PageObject
  module PageBuilder
    class ListBuilder < ElementBuilder
      class << self
        def list(name, &block)
          create_element ListElement, name, &block
        end#list
      end#class << self
    end#ListBuilder

    PageBuilder.factories[:list] = ListBuilder
  end#PageBuilder
end#PageObject