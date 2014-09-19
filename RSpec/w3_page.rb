require_relative '../PageObject/page'

class W3Page < Page

  def initialize(_driver)
    super

    create_click_object 'HTML Tutorial',
                        selector: selector(:a, text: 'HTML Tutorial')

  end
end