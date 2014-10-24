require 'rspec'
require_relative '../PageObject/page_object'
require_relative '../Driver/watir_driver'

context 'Page testing' do
  require_relative '../PageObject/page'

  class Page1 < Page
    def initialize(_driver)
      super

      create_click_object name: 'Page2',
                          selector: selector(type: :link,
                                             specifier: {text: 'Submit2'}),
                          next_page: Page2
    end
  end

  class Page2 < Page
    def initialize(_driver)
      super
    end
  end


  describe Page do

    before(:all) do
      @browser = WatirDriver.new
      Page.page = Page1.new @browser
    end

    after(:all) do
      @browser.send :close
    end

    it '.send(NAME)' do
      expect(Page.page.send('Page2')).to be_instance_of(PageObject::ClickElement)
    end

    it 'changes pages' do
      @browser.send :goto, "file://#{Dir.pwd}\\page_object_page_1.html"

      Page.page.send('Page2').send(:click)
      expect(Page.page).to be_instance_of(Page2)
    end#do

  end#Page
end#context

describe PageObject::ElementObject do

  before(:all) do
    @driver = WatirDriver.new
    Page.page = Page1.new @driver
  end

  after(:all) do
    @driver.send :close
  end

  before(:each) do
    @driver.send :goto, "file://#{Dir.pwd}\\page_object_page_1.html"
  end#do

  it '.send(:see)' do
    e = PageObject::ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(type: :button,
                                                                         specifier: {id: 'form2button'})

    expect(e.send(:see)).to equal(true)
  end#do

  context 'added action' do

    it '.send(:hover)' do
      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(type: :button,
                                                                           specifier: {id: 'hover_target'}),
                                        actions: {hover: :hover}

      f = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(type: :span,
                                                                           specifier: {id: 'hover_text'}),
                                        actions: {text: :text}

      expect(e.send(:hover)).to equal(nil)
      expect(f.send(:text)).to eq('Hover Target - Success')
    end#it
  end#context

  context 'multiple selectors' do

    it '.send(:text) on item with multiple selectors' do
      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: [PageObject::Selector.new(type: :element,
                                                                            specifier: {text: 'Deep child in list'}),
                                                  PageObject::Selector.new(type: :parent),
                                                  PageObject::Selector.new(type: :parent)],
                                        actions: {text: :text}

      expect(e.send(:text)).to include('Element 1')
    end#it
  end#context

  it '.send(:see_text_as, TEXT)' do
    e = PageObject::ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(type: :element,
                                                                         specifier: {id: 'element2'}),
                                      actions: {see_text_as: :see_text_as}

    expect(e.send(:see_text_as, 'Fake Element 2')).to equal(true)
  end

  context 'selector with no type specified' do

    it '.send(:see)' do
      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(specifier: {id: 'element2'})

      expect(e.send(:see)).to equal(true)
    end#it
  end#context

  context 'before block is ran' do

    it '.send(:see)' do
      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(specifier: {id: 'decorator_test_li_2'}),
                                        before: proc {|driver| driver.send(:style).match(/blue/)}

      expect(e.send(:see)).to equal(false)

      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(specifier: {id: 'decorator_test_li_2'}),
                                        before: proc {|driver| driver.send(:style).match('color: green')}

      expect(e.send(:see)).to equal(true)
    end#it

    it '.send(NAME).send(:see)' do
      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(type: :li,
                                                                           specifier: {id: 'decorator_test_li_2'}),
                                        children: PageObject::ElementObject.new(driver: @driver,
                                                                                name: 'Highlighted',
                                                                                before: proc {|driver| driver.send(:style).match(/green/)})

      expect(e.send('Highlighted').send(:see)).to equal(true)
    end#it
  end#context

  context 'searching by css' do
    it '.send(:see)' do
      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(type: :li,
                                                                           specifier: {css: 'li[style="color:green"]'})

      expect(e.send(:see)).to equal(true)

      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(type: :li,
                                                                           specifier: {css: 'li[style="color:red"]'})

      expect(e.send(:see)).to equal(false)
    end#it

    it '.send(NAME).send(:see)' do
      e = PageObject::ElementObject.new driver: @driver,
                                        name: 'name',
                                        selector: PageObject::Selector.new(type: :li,
                                                                           specifier: {id: 'decorator_test_li_2'}),
                                        children: PageObject::ElementObject.new(driver: @driver,
                                                                                name: 'Highlighted',
                                                                                selector: [PageObject::Selector.new(type: :parent),
                                                                                           PageObject::Selector.new(type: :li,
                                                                                                         specifier: {css: 'li[style="color:green"]'})])

      expect(e.send('Highlighted').send(:see)).to equal(true)
    end#it
  end#context

  describe PageObject::ClickElement do

    it '.send(:click)' do
      e = PageObject::ClickElement.new driver: @driver,
                                       name: 'name',
                                       selector: PageObject::Selector.new(type: :button,
                                                                          specifier: {id: 'form2button'})

      expect(e.send(:click)).to be_instance_of(Array)
    end#do

    context 'driver added method is called' do

      it '.send(:click) driver added method is called' do
        e = PageObject::ClickElement.new driver: @driver,
                                         name: 'name',
                                         selector: PageObject::Selector.new(type: :button,
                                                                            specifier: {id: 'form2button'}),
                                         actions: {click: :on_mouse_down}

        expect(e.send(:click)).to equal(true)
      end#it
    end#context
  end#ClickElement

  describe PageObject::TextInputElement do

    it '.send(:set, TEXT)' do
      e = PageObject::TextInputElement.new driver: @driver,
                                           name: 'First name',
                                           selector: PageObject::Selector.new(type: :text_field,
                                                                              specifier: {id: 'email'})


      expect(e.send(:set, 'Test')).to equal(nil)
    end#do

    it '.send(:value)' do
      e = PageObject::TextInputElement.new driver: @driver,
                                           name: 'First name',
                                           selector: PageObject::Selector.new(type: :text_field,
                                                                              specifier: {id: 'email'})

      e.send(:set, 'Test')
      expect(e.send(:value)).to eq('Test')
    end#do
  end#TextInputElement

  describe PageObject::ListElement do

    context 'action pass through' do

      it '.send(#).send(:click)' do
        e = PageObject::ListElement.new driver: @driver,
                                        name: 'List1',
                                        selector: PageObject::Selector.new(type: :form,
                                                                           specifier: {id: 'form'}),
                                        children: [PageObject::ClickElement.new(driver: @driver,
                                                                                name: 'Link',
                                                                                selector: PageObject::Selector.new(type: :a)),
                                                   PageObject::TextInputElement.new(driver: @driver,
                                                                                    name: 'TextField',
                                                                                    selector: PageObject::Selector.new(type: :text_field))]

        expect(e.send(1).send(:click)).to be_instance_of(Array)
      end#do
    end#context

    it '.send(#).send(NAME).send(:set, TEXT)' do
      e = PageObject::ListElement.new driver: @driver,
                                      name: 'List2',
                                      selector: PageObject::Selector.new(type: :form,
                                                                         specifier: {id: 'form'}),
                                      children: [PageObject::ClickElement.new(driver: @driver,
                                                                              name: 'Link',
                                                                              selector: PageObject::Selector.new(type: :a)),
                                                 PageObject::TextInputElement.new(driver: @driver,
                                                                                  name: 'TextField',
                                                                                  selector: PageObject::Selector.new(type: :text_field))]

      expect(e.send(0).send('TextField').send(:set, 'Test')).to equal(nil)
    end#do
  end#ListElement

  describe PageObject::CheckboxElement do

    it '.send(NAME).send(:check)' do
      e =  PageObject::CheckboxElement.new driver: @driver,
                                           name: 'name',
                                           selector: PageObject::Selector.new(type: :checkbox,
                                                                              specifier: {name: 'checkboxtest1'})

      expect(e.send(:check)).to equal(nil)
    end#do
  end#CheckboxElement

  describe PageObject::SaveElement do

    it '.send(:save)' do
      e = PageObject::SaveElement.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(type: :li,
                                                                         specifier: {id: 'element2'}),
                                      actions: {save: :text}

      expect(e.send(:save)).to eq('Fake Element 2')
    end#do

    it '.send(:value)' do
      e = PageObject::SaveElement.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(type: :li,
                                                                         specifier: {id: 'element2'}),
                                      actions: {save: :text}

      e.send(:save)
      expect(e.send(:value)).to eq('Fake Element 2')
    end#do
  end#SaveElement
end#ElementObject