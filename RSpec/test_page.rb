require_relative '../page_object'

class TestPage
  include PageObject

  def initialize(_driver)
    super

    create_click_object 'Google', selector(:a, id: 'link1')
    create_click_object 'W3Schools', selector(:a, id: 'link2')

    create_list 'List1', selector(:ul, id: 'list'), click_object('Result', selector(:a, {}))
    create_list 'List2', selector(:ul, id: 'compound_list'), [click_object('Link', selector(:a, {})), text_field('TextField', selector(:text_field, {}))]

    create_checkbox 'I have a bike', selector(:input, value: 'Bike')
  end
end