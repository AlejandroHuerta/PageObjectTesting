require 'singleton'
require_relative '../../lib/page_object/page_object'

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
end#PageObject