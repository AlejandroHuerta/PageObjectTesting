require 'rspec'
require_relative 'w3_page'
require_relative 'test_page'
require_relative '../PageObject/page_object'
require_relative '../Driver/watir_driver'


describe Page do

  before(:all) do
    @browser = WatirDriver.new
    Page.page = TestPage.new @browser
  end

  after(:all) do
    @browser.send :close
  end

  it '.send(NAME)' do
    expect(Page.page.send('W3Schools')).to be_instance_of(PageObject::ClickElement)
  end

  it 'changes pages' do
    @browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    Page.page.send('W3Schools').send(:click)
    expect(Page.page).to be_instance_of(W3Page)
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
    e = PageObject::ElementObject.new @driver,
                                      'name',
                                      selector: PageObject::Selector.new(:button, id: 'dud_button')

    expect(e.send(:see)).to equal(true)
  end#do

  describe PageObject::ClickElement do

    it '.send(:click)' do
      e = PageObject::ClickElement.new @driver,
                                       'name',
                                       selector: PageObject::Selector.new(:button, id: 'dud_button')

      expect(e.send(:click)).to be_instance_of(Array)
    end#do

    it '.send(:click) driver added method is called' do
      e = PageObject::ClickElement.new @driver,
                                       'name',
                                       selector: PageObject::Selector.new(:button, id: 'dud_button'),
                                       actions: {click: :on_mouse_down}

      expect(e.send(:click)).to equal(true)
    end
  end#ClickElement

  describe PageObject::TextInputElement do

    it '.send(:set, TEXT)' do
      e = PageObject::TextInputElement.new @driver,
                                           'First name',
                                           selector: PageObject::Selector.new(:text_field, id: 'tf1')


      expect(e.send(:set, 'Test')).to equal(nil)
    end#do

    it '.send(:value)' do
      e = PageObject::TextInputElement.new @driver,
                                           'First name',
                                           selector: PageObject::Selector.new(:text_field, id: 'tf1')

      e.send(:set, 'Test')
      expect(e.send(:value)).to eq('Test')
    end#do
  end#TextInputElement

  describe PageObject::ListElement do

    it '.send(#).send(:click)' do
      e = PageObject::ListElement.new @driver,
                                      'List1',
                                      selector: PageObject::Selector.new(:ul, id: 'list'),
                                      children: PageObject::ClickElement.new(@driver,
                                                                             'Result',
                                                                             selector: PageObject::Selector.new(:a))

      expect(e.send(1).send(:click)).to be_instance_of(Array)
    end#do

    it '.send(#).send(NAME).send(:set, TEXT)' do
      e = PageObject::ListElement.new @driver,
                                      'List2',
                                      selector: PageObject::Selector.new(:ul, id: 'compound_list'),
                                      children: [PageObject::ClickElement.new(@driver,
                                                                              'Link',
                                                                              selector: PageObject::Selector.new(:a)),
                                                 PageObject::TextInputElement.new(@driver,
                                                                                  'TextField',
                                                                                  selector: PageObject::Selector.new(:text_field))]

      expect(e.send(0).send('TextField').send(:set, 'Test')).to equal(nil)
    end#do
  end#ListElement

  describe PageObject::CheckboxElement do

    it '.send(NAME).send(:check)' do
      e =  PageObject::CheckboxElement.new @driver,
                                           'I have a bike',
                                           selector: PageObject::Selector.new(:checkbox, value: 'Bike')

      expect(e.send(:check)).to equal(nil)
    end#do
  end#CheckboxElement

  describe PageObject::SaveElement do

    it '.send(:save)' do
      e = PageObject::SaveElement.new @driver,
                                      'Reddit',
                                      selector: PageObject::Selector.new(:a, id: 'link3'),
                                      actions: {save: :text}

      expect(e.send(:save)).to eq('Reddit')
    end#do

    it '.send(:value)' do
      e = PageObject::SaveElement.new @driver,
                                      'Reddit',
                                      selector: PageObject::Selector.new(:a, id: 'link3'),
                                      actions: {save: :text}

      e.send(:save)
      expect(e.send(:value)).to eq('Reddit')
    end#do
  end#SaveElement
end#ElementObject