require_relative 'page_builder'
require_relative '../../../lib/elements/text_input_element'
require_relative 'element_builder'

module PageObject
  module PageBuilder
    class TextInputBuilder < ElementBuilder
      class << self
        def text(name, &block)
          create_element TextInputElement, name, &block
        end#text
      end#class << self
    end#TextInputBuilder

    PageBuilder.factories[:text] = TextInputBuilder
  end#PageBuilder
end#PageObject