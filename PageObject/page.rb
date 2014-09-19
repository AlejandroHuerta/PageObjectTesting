require_relative 'page_object'

class Page
  include PageObject

  class << self
    attr_accessor :page

    def build_page(_class)
      Object::const_get(_class.name).new @driver
    end
  end

  attr_accessor :driver
  attr_reader :elements

  def initialize(_driver)
    @driver = _driver
    @elements = {}
  end #initialize

  def send(*_args)
    if @elements.has_key? _args[0]
      @elements[_args[0]]
    else
      super
    end #else
  end #send

  def method_missing(_method_name, *_args, &_block)
    if @driver.respond_to? _method_name
      @driver.send _method_name, *_args, &_block
    else
      super
    end #else
  end #method_missing
end