require_relative 'element_object'

class KeySequenceElement < ElementObject
  def get_actions
    {do: :do, enter: :enter}
  end#get_actions

  def enter(driver, *_args)
    driver.send params[:actions][:enter], *params[:keys]
  end

  def do(driver, *args)
    self.enter driver, *args
  end
end#KeySequenceElement