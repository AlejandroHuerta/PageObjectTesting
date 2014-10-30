require_relative 'element_object'

module Elements
  class CheckboxElement < ElementObject
    def initialize(hash)
      if hash[:actions].nil?
        hash[:actions] = {:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}
      else
        hash[:actions].merge!({:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}){|_key, oldval, _newval| oldval}
      end
      super
    end#initialize
  end#CheckboxObject
end#Elements

module PageObject
  def checkbox_object(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    Elements::CheckboxElement.new hash
  end
end