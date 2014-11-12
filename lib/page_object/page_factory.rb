require 'singleton'
require_relative '../../lib/page_object/page_object'
require_relative 'page'
require_relative 'page_builder/page_builder'

module PageObject
  class PageFactory
    include Singleton

    def add_page(name, page)
      @pages ||= {}
      @pages[name] = page
    end#add_page

    def get_page(name)
      @pages[name]
    end#get_page
  end#PageFactory

  module PageBuilder
    class PageBuilder
      class << self
        def page(name, *_args, &block)
          @factories ||= {}
          #reset the stack
          @stack = []
          #place our hash
          @stack.push name: name
          #run the block given
          instance_eval &block if block_given?
          #take the top element and pass as the page's hash
          page_hash = @stack.pop
          PageFactory.instance.add_page(page_hash[:name], Page.new(page_hash))
        end#page
      end#class << self
    end#class PageBuilder
  end#module PageBuilder
end#PageObject

class Page
  class << self
    def build_page(name)
      PageFactory.instance.get_page name
    end#build_page
  end#class << self
end#Page