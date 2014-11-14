require_relative 'element_object'

class SelectListElement < ElementObject
  def get_actions
    {select: :select, options: :options}
  end#get_actions
end#SelectListElement