require_relative '../PageObject/page'

class TestPage < Page

  def initialize(_driver)
    super

    create_click_object 'Google',
                        selector: selector(type: :a, id: 'link1')
    create_click_object 'W3Schools',
                        selector: selector(type: :a, id: 'link2'),
                        next_page: W3Page
    create_click_object 'Dud',
                        selector: selector(type: :button, id: 'dud_button')

    create_click_object 'Mouse Down',
                        selector: selector(type: :button, id: 'dud_button'),
                        actions: {click: :on_mouse_down}

    create_text_field 'First name',
                      selector: selector(type: :text_field, id: 'tf1')

    create_checkbox 'I have a bike',
                    selector: selector(type: :checkbox, value: 'Bike')

    create_save 'Reddit',
                selector: selector(type: :a, id: 'link3'),
                actions: {save: :text}

    create_list 'List1',
                selector: selector(type: :ul, id: 'list'),
                children: click_object('Result',
                                       selector: selector(type: :a))

    create_list 'List2',
                selector: selector(type: :ul, id: 'compound_list'),
                children: [click_object('Link',
                                        selector: selector(type: :a)),
                           text_field('TextField',
                                      selector: selector(type: :text_field))]


  end
end