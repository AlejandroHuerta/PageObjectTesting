require_relative '../lib/page_object/page'
require_relative '../lib/page_object/page_builder'

include PageObject

context 'Page' do
  it 'creates a new page' do
    test_page = PageBuilder.define

    expect(test_page).to be_instance_of(Page)
  end#it
end#context Page

context 'ElementObject' do
  it 'creates an element' do
    test_page = PageBuilder.define do
      element 'Element'
    end#define

    expect(test_page.send('Element')).to be_instance_of(ElementObject)
  end#it

  it 'element with selector' do
    test_page = PageBuilder.define do
      element 'Element' do
        selector type: :button, specifier: {id: 'form2button'}
      end#element
    end#define

    expect(test_page.send('Element').params[:selector][0]).to_not eql(nil)
    expect(test_page.send('Element').params[:selector][0].type).to equal(:button)
    expect(test_page.send('Element').params[:selector][0].specifier).to eql({id: 'form2button'})
  end#it

  it 'element with actions' do
    test_page = PageBuilder.define do
      element 'Element' do
        actions text: :text, see: :with_my_eyes
      end#element
    end#define

    expect(test_page.send('Element').params[:actions].has_key? :text).to equal(true)
    expect(test_page.send('Element').params[:actions][:see]).to equal(:with_my_eyes)
  end#it

  it 'element with child' do
    test_page = PageBuilder.define do
      element 'Element' do
        element 'Child'
      end#element
    end#define

    expect(test_page.send('Element').send('Child')).to be_instance_of(ElementObject)
  end#it
end#context Element

context 'ClickElement' do
  it 'creates a click element' do
    test_page = PageBuilder.define do
      click 'ClickElement'
    end#define

    expect(test_page.send('ClickElement')).to be_instance_of(ClickElement)
  end#it
end#context ClickElement

context 'CheckboxElement' do
  it 'creates a checkbox element' do
    test_page = PageBuilder.define do
      checkbox 'CheckboxElement'
    end#define

    expect(test_page.send('CheckboxElement')).to be_instance_of(CheckboxElement)
  end#it
end#context CheckboxElement

context 'ListElement' do
  it 'creates a list element' do
    test_page = PageBuilder.define do
      list 'ListElement'
    end#define

    expect(test_page.send('ListElement')).to be_instance_of(ListElement)
  end#it
end#context ListElement

context 'SaveElement' do
  it 'creates a save element' do
    test_page = PageBuilder.define do
      save 'SaveElement'
    end#define

    expect(test_page.send('SaveElement')).to be_instance_of(SaveElement)
  end#it
end#context SaveElement

context 'TextInputElement' do
  it 'creates a text input element' do
    test_page = PageBuilder.define do
      text_input 'TextInputElement'
    end#define

    expect(test_page.send('TextInputElement')).to be_instance_of(TextInputElement)
  end#it
end#context TextInputElement