require_relative '../lib/page_object/page'
require_relative '../lib/page_object/page_builder/page_builder'
require_relative '../lib/page_object/page_builder/element_builder'
require_relative '../lib/page_object/page_builder/click_builder'
require_relative '../lib/page_object/page_builder/checkbox_builder'
require_relative '../lib/page_object/page_builder/list_builder'
require_relative '../lib/page_object/page_builder/save_builder'
require_relative '../lib/page_object/page_builder/text_input_builder'
require_relative '../lib/page_object/page_builder/selector_builder'

include PageObject::PageBuilder

context 'Page' do
  it 'creates a new page' do
    page = PageBuilder.page ''

    expect(page).to be_instance_of(Page)
  end#it
end#context Page

context 'ElementObject' do
  it 'creates an element' do
    page = PageBuilder.page '' do
      element 'Element'
    end#define

    expect(page.send('Element')).to be_instance_of(ElementObject)
  end#it

  it 'element with selector' do
    page = PageBuilder.page '' do
      element 'Element' do
        selector type: :button, specifier: {id: 'form2button'}
      end#element
    end#define

    expect(page.send('Element').params[:selector][0]).to_not eql(nil)
    expect(page.send('Element').params[:selector][0].type).to equal(:button)
    expect(page.send('Element').params[:selector][0].specifier).to eql({id: 'form2button'})
  end#it

  it 'element with actions' do
    page = PageBuilder.page '' do
      element 'Element' do
        actions text: :text, see: :with_my_eyes
      end#element
    end#define

    expect(page.send('Element').params[:actions].has_key? :text).to equal(true)
    expect(page.send('Element').params[:actions][:see]).to equal(:with_my_eyes)
  end#it

  it 'element with child' do
    page = PageBuilder.page '' do
      element 'Element' do
        element 'Child'
      end#element
    end#define

    expect(page.send('Element').send('Child')).to be_instance_of(ElementObject)
  end#it
end#context Element

context 'ClickElement' do
  it 'creates a click element' do
    page = PageBuilder.page '' do
      click 'ClickElement'
    end#define

    expect(page.send('ClickElement')).to be_instance_of(ClickElement)
  end#it
end#context ClickElement

context 'CheckboxElement' do
  it 'creates a checkbox element' do
    page = PageBuilder.page '' do
      checkbox 'CheckboxElement'
    end#define

    expect(page.send('CheckboxElement')).to be_instance_of(CheckboxElement)
  end#it
end#context CheckboxElement

context 'ListElement' do
  it 'creates a list element' do
    page = PageBuilder.page '' do
      list 'ListElement'
    end#define

    expect(page.send('ListElement')).to be_instance_of(ListElement)
  end#it

  it 'list with multiple children' do
    page = PageBuilder.page '' do
      list 'ListElement' do
        element 'Element1'
        element 'Element2'
      end#list
    end#define

    expect(page.send('ListElement').send('Element1')).to be_instance_of(ElementObject)
    expect(page.send('ListElement').send('Element2')).to be_instance_of(ElementObject)
  end#it
end#context ListElement

context 'SaveElement' do
  it 'creates a save element' do
    page = PageBuilder.page '' do
      save 'SaveElement'
    end#define

    expect(page.send('SaveElement')).to be_instance_of(SaveElement)
  end#it
end#context SaveElement

context 'TextInputElement' do
  it 'creates a text input element' do
    page = PageBuilder.page '' do
      text 'TextInputElement'
    end#define

    expect(page.send('TextInputElement')).to be_instance_of(TextInputElement)
  end#it
end#context TextInputElement


context 'full example' do
=begin
  page = PageBuilder.define do
    text 'Email1' do
      selector type: :text_field, specifier: {id: 'email'}
    end
    text 'Email2' do
      selector type: :text_field, specifier: {id: 'email2'}
    end
    click 'Submit3' do
      selector type: :div, specifier: {id: 'submit3'}
      selector type: :a
      next_page 'Page2'
    end
    list 'Checkboxes' do
      selector type: :form, specifier: {id: 'checkboxparent'}
      checkbox 'Checkbox' do
        selector type: :checkbox
      end
    end
    element 'List item' do
      selector type: :ul, specifier: {id: 'decorator_test'}
      element 'Highlighted' do
        selector type: :li, specifier: {id: 'decorator_test_li_2'}
        check style: /green/
      end
    end
  end
=end
end