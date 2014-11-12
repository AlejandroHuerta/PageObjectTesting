require_relative 'page_builder'
require_relative '../../../lib/elements/save_element'
require_relative 'element_builder'

module PageObject
  module PageBuilder
    class SaveBuilder < ElementBuilder
      class << self
        def save(name, &block)
          create_element SaveElement, name, &block
        end#save
      end#class << self
    end#SaveBuilder

    PageBuilder.factories[:save] = SaveBuilder
  end#PageBuilder
end#PageObject