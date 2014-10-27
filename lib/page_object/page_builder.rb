require_relative 'page'

module PageObject
  module PageBuilder
    class << self
      attr_reader :page, :element
      def define(&block)
        @page = Page.new @driver
        instance_eval &block if block_given?
        @page
      end

      def element(name, &block)
        @element = ElementObject.new name: name
        instance_eval &block if block_given?
        @page.children[name] = @element
      end

      def selector(hash)
        @element.params[:selector][0] = Selector.new hash
      end

      def actions(hash)
        @element.params[:actions].merge!(hash) {|_key, _oldval, newval| newval}
      end
    end
  end
end