require_relative 'page_object'

module PageObject
  module PageBuilder
    class << self
      def build_page(_class)
        Object::const_get(_class).new @driver
      end
    end
  end
end