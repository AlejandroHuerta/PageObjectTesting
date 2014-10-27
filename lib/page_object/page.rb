require_relative 'page_object'

class Page
  include PageObject

  class << self
    attr_accessor :page, :driver

    def build_page(klass)
      Object::const_get(klass.name).new
    end
  end

  attr_reader :params

  def initialize(hash = {})
    @params = hash
    @params[:children] ||= {}
  end #initialize

  def send(*args)
    if @params[:children].has_key? args[0]
      @params[:children][args[0]].params[:driver] = Page.driver
      @params[:children][args[0]]
    else
      super
    end #else
  end #send

  def method_missing(method_name, *args, &block)
    if @params[:driver].respond_to? method_name
      @params[:driver].send method_name, *args, &block
    else
      super
    end #else
  end #method_missing
end