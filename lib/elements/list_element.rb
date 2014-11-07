require_relative 'element_object'

class ListElement < ElementObject
  def get_actions
    {Fixnum => Fixnum}
  end

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

module PageObject
  def list(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    ListElement.new hash
  end#list
end#page_object