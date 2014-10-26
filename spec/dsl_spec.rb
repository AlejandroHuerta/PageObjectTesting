require_relative '../lib/page_object/page'
require_relative '../lib/page_object/page_builder'

include PageObject

context 'Page' do
  it 'creates a new page' do
    test_page = PageBuilder.define

    expect(test_page).to be_instance_of(Page)
  end
end

context 'Element' do
  it 'creates an element' do
    test_page = PageBuilder.define do
      PageBuilder.element 'Element'
    end

    expect(test_page.send('Element')).to be_instance_of(ElementObject)
  end

  it 'element with selector' do
    test_page = PageBuilder.define do
      PageBuilder.element 'Element' do
        PageBuilder.selector type: :button, specifier: {id: 'form2button'}
      end
    end

    expect(test_page.send('Element').params[:selector][0]).to_not eql(nil)
    expect(test_page.send('Element').params[:selector][0].type).to equal(:button)
    expect(test_page.send('Element').params[:selector][0].specifier).to eql({id: 'form2button'})
  end

  it 'element with actions' do
    test_page = PageBuilder.define do
      PageBuilder.element 'Element' do
        PageBuilder.actions text: :text, see: :with_my_eyes
      end
    end

    expect(test_page.send('Element').params[:actions].has_key? :text).to equal(true)
    expect(test_page.send('Element').params[:actions][:see]).to equal(:with_my_eyes)
  end

  it 'element with child' do
    test_page = PageBuilder.define do
      PageBuilder.element 'Element' do
        PageBuilder.element 'Child'
      end
    end

    expect(test_page.send('Element').send('Child')).to be_instance_of(ElementObject)
  end
end