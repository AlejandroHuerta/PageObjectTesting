require_relative 'page_builder'
require_relative '../../../lib/elements/click_element'
require_relative 'element_builder'

module PageObject
  module PageBuilder
    class ClickBuilder < ElementBuilder
      class << self
        def click(name, &block)
          create_element ClickElement, name, &block
        end#click
      end#class << self
    end#ElementBuilder

    PageBuilder.factories[:click] = ClickBuilder
  end#PageBuilder
end#PageObject