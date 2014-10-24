require_relative 'element_object'

module PageObject
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
        @params[:children].each do |child|
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

  def list(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    ListElement.new hash
  end#list
end#PageObject