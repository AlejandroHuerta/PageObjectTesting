require_relative 'page_builder'
require_relative '../../../lib/elements/checkbox_element'
require_relative 'element_builder'

module PageObject
  module PageBuilder
    class CheckBoxBuilder < ElementBuilder
      class << self
        def checkbox(name, &block)
          create_element CheckboxElement, name, &block
        end#checkbox
      end#class << self
    end#CheckboxBuilder

    PageBuilder.factories[:checkbox] = CheckBoxBuilder
  end#PageBuilder
end#PageObject