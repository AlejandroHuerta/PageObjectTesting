require_relative 'page_builder'
require_relative '../../../lib/elements/selector'
require_relative 'element_builder'

module PageObject
  module PageBuilder
    class SelectorBuilder
      class << self
        def selector(hash, *_args, &_block)
          PageBuilder.stack.last[:selector] ||= []
          PageBuilder.stack.last[:selector].push Selector.new hash
        end#selector
      end#class << self
    end#SelectorBuilder

    PageBuilder.factories[:selector] = SelectorBuilder
  end#PageBuilder
end#PageObject