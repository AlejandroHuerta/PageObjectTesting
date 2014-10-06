require 'rspec'
require_relative 'w3_page'
require_relative 'test_page'
require_relative '../PageObject/page_object'
require_relative '../Driver/watir_driver'

class Page1 < Page
  def initialize(_driver)
    super

    create_click_object name: 'Page2',
                        selector: selector(type: :link,
                                           locator: {text: 'Submit2'}),
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

describe PageObject::ElementObject do

  before(:all) do
    @driver = WatirDriver.new
    Page.page = TestPage.new @driver
  end

  after(:all) do
    @driver.send :close
  end

  before(:each) do
    @driver.send :goto, "file://#{Dir.pwd}\\TestPage.html"
  end#do

  it '.send(:see)' do
    e = PageObject::ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(type: :button,
                                                                         locator: {id: 'dud_button'})

    expect(e.send(:see)).to equal(true)
  end#do

  it '.send(:text) on item with multiple selectors' do
    e = PageObject::ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: [PageObject::Selector.new(type: :element,
                                                                          locator: {id: 'unique_item'}),
                                                PageObject::Selector.new(type: :parent,
                                                                         locator: nil),
                                                PageObject::Selector.new(type: :parent,
                                                                         locator: nil)],
                                      actions: {text: :text}

    expect(e.send(:text)).to include('Pastries')
  end#do

  it '.send(:see_text_as, TEXT)' do
    e = PageObject::ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(type: :element,
                                                                         locator: {id: 'unique_item'}),
                                      actions: {see_text_as: :see_text_as}

    expect(e.send(:see_text_as, 'Croissant')).to equal(true)
  end

  it '.send(:see) element with no type specified' do
    e = PageObject::ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(locator: {id: 'unique_item'})

    expect(e.send(:see)).to equal(true)
  end

  describe PageObject::ClickElement do

    it '.send(:click)' do
      e = PageObject::ClickElement.new driver: @driver,
                                       name: 'name',
                                       selector: PageObject::Selector.new(type: :button,
                                                                          locator: {id: 'dud_button'})

      expect(e.send(:click)).to be_instance_of(Array)
    end#do

    it '.send(:click) driver added method is called' do
      e = PageObject::ClickElement.new driver: @driver,
                                       name: 'name',
                                       selector: PageObject::Selector.new(type: :button,
                                                                          locator: {id: 'dud_button'}),
                                       actions: {click: :on_mouse_down}

      expect(e.send(:click)).to equal(true)
    end
  end#ClickElement

  describe PageObject::TextInputElement do

    it '.send(:set, TEXT)' do
      e = PageObject::TextInputElement.new driver: @driver,
                                           name: 'First name',
                                           selector: PageObject::Selector.new(type: :text_field,
                                                                              locator: {id: 'tf1'})


      expect(e.send(:set, 'Test')).to equal(nil)
    end#do

    it '.send(:value)' do
      e = PageObject::TextInputElement.new driver: @driver,
                                           name: 'First name',
                                           selector: PageObject::Selector.new(type: :text_field,
                                                                              locator: {id: 'tf1'})

      e.send(:set, 'Test')
      expect(e.send(:value)).to eq('Test')
    end#do
  end#TextInputElement

  describe PageObject::ListElement do

    it '.send(#).send(:click)' do
      e = PageObject::ListElement.new driver: @driver,
                                      name: 'List1',
                                      selector: PageObject::Selector.new(type: :ul,
                                                                         locator: {id: 'list'}),
                                      children: PageObject::ClickElement.new(driver: @driver,
                                                                             name: 'Result',
                                                                             selector: PageObject::Selector.new(type: :a))

      expect(e.send(1).send(:click)).to be_instance_of(Array)
    end#do

    it '.send(#).send(NAME).send(:set, TEXT)' do
      e = PageObject::ListElement.new driver: @driver,
                                      name: 'List2',
                                      selector: PageObject::Selector.new(type: :ul,
                                                                         locator: {id: 'compound_list'}),
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
                                           name: 'I have a bike',
                                           selector: PageObject::Selector.new(type: :checkbox,
                                                                              locator: {value: 'Bike'})

      expect(e.send(:check)).to equal(nil)
    end#do
  end#CheckboxElement

  describe PageObject::SaveElement do

    it '.send(:save)' do
      e = PageObject::SaveElement.new driver: @driver,
                                      name: 'Reddit',
                                      selector: PageObject::Selector.new(type: :a,
                                                                         locator: {id: 'link3'}),
                                      actions: {save: :text}

      expect(e.send(:save)).to eq('Reddit')
    end#do

    it '.send(:value)' do
      e = PageObject::SaveElement.new driver: @driver,
                                      name: 'Reddit',
                                      selector: PageObject::Selector.new(type: :a,
                                                                         locator: {id: 'link3'}),
                                      actions: {save: :text}

      e.send(:save)
      expect(e.send(:value)).to eq('Reddit')
    end#do
  end#SaveElement
end#ElementObject