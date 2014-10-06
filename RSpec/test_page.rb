require_relative '../PageObject/page'

class TestPage < Page

  def initialize(_driver)
    super

    create_click_object name: 'Google',
                        selector: selector(type: :a,
                                           locator: {id: 'link1'})
    create_click_object name: 'W3Schools',
                        selector: selector(type: :a,
                                           locator: {id: 'link2'}),
                        next_page: W3Page
    create_click_object name: 'Dud',
                        selector: selector(type: :button,
                                           locator: {id: 'dud_button'})

    create_click_object name: 'Mouse Down',
                        selector: selector(type: :button,
                                           locator: {id: 'dud_button'}),
                        actions: {click: :on_mouse_down}

    create_text_field name: 'First name',
                      selector: selector(type: :text_field,
                                         locator: {id: 'tf1'})

    create_checkbox name: 'I have a bike',
                    selector: selector(type: :checkbox,
                                       locator: {value: 'Bike'})

    create_save name: 'Reddit',
                selector: selector(type: :a,
                                   locator: {id: 'link3'}),
                actions: {save: :text}

    create_list name: 'List1',
                selector: selector(type: :ul, id: 'list'),
                children: click_object(name: 'Result',
                                       selector: selector(type: :a))

    create_list name: 'List2',
                selector: selector(type: :ul,
                                   locator: {id: 'compound_list'}),
                children: [click_object(name: 'Link',
                                        selector: selector(type: :a)),
                           text_field(name: 'TextField',
                                      selector: selector(type: :text_field))]


  end
end