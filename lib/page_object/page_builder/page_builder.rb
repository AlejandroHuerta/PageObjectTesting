require_relative '../page'

module PageObject
  module PageBuilder
    class PageBuilder
      class << self
        attr_reader :stack, :factories

        def page(name, *_args, &block)
          @factories ||= {}
          #reset the stack
          @stack = []
          #place our hash
          @stack.push name: name
          #run the block given
          instance_eval &block if block_given?
          #take the top element and pass as the page's hash
          Page.new @stack.pop
        end#page

        def actions(hash)
          @stack.last[:actions] ||= {}
          @stack.last[:actions].merge!(hash) {|_key, _oldval, newval| newval}
        end#actions

        def next_page(name)
          @stack.last[:next_page] = name
        end#next_page

        def check(hash)
          method_value = hash.shift
          @stack.last[:before] = proc {|driver| driver.send(method_value[0]).match method_value[1]}
        end

        def factories
          @factories ||= {}
        end#factories

        def method_missing(method, *args, &block)
          if @factories.has_key? method
            @factories[method].send method, *args, &block
          else
            super
          end#else
        end#method_missing
      end#class << self
    end#class PageBuilder
  end#module PageBuilder
end#PageObject