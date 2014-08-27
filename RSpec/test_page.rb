require_relative '../PageObject/page_object'

class TestPage
  include PageObject

  def initialize(_driver)
    super

    create_click_object 'Google',
                        selector: selector(:a, id: 'link1')
    create_click_object 'W3Schools',
                        selector: selector(:a, id: 'link2')

    create_text_field 'First name',
                      selector: selector(:text_field, id: 'tf1')

    create_checkbox 'I have a bike',
                    selector: selector(:checkbox, value: 'Bike')

    create_save 'Reddit',
                selector: selector(:a, id: 'link3')

    create_list 'List1',
                selector: selector(:ul, id: 'list'),
                children: click_object('Result',
                                       selector: selector(:a))
    create_list 'List2',
                selector: selector(:ul, id: 'compound_list'),
                children: [click_object('Link',
                                        selector: selector(:a)),
                           text_field('TextField',
                                      selector: selector(:text_field))]


  end
end