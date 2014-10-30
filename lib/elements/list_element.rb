require_relative 'element_object'

module Elements
  class ListElement < ElementObject
    def initialize(hash)
      if hash[:actions].nil?
        hash[:actions] = {Fixnum => Fixnum}
      else
        hash[:actions].merge!({Fixnum => Fixnum}){|_key, oldval, _newval| oldval}
      end#else
      super
    end #initialize

    def Fixnum(_driver, *args)
      if args[0].is_a? Fixnum
        @params[:children].each do |_key, child|
          if child.params[:selector][0].specifier.nil?
            child.params[:selector][0].specifier = {index: args[0]}
          else
            child.params[:selector][0].specifier[:index] = args[0]
          end
        end #do
      end #if
      self
    end#Fixnum
  end #class list_object
end#Elements

module PageObject
  def list_object(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    Elements::ListElement.new hash
  end#list
end#page_object