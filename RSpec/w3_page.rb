require_relative '../PageObject/page'

class W3Page < Page

  def initialize(_driver)
    super

    create_click_object name: 'HTML Tutorial',
                        selector: selector(type: :a, text: 'HTML Tutorial')

  end
end