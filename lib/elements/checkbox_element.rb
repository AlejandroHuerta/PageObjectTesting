require_relative 'element_object'

class CheckboxElement < ElementObject
  def get_actions
    {:check => :check, :set => :set, :clear => :clear, :checked? => :checked?, :set? => :set?}
  end
end#CheckboxObject

module PageObject
  def checkbox_object(hash)
    hash[:driver] = @driver unless hash.has_key? :driver
    CheckboxElement.new hash
  end
end