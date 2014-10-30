require_relative '../lib/page_object/page'
require_relative '../lib/driver/watir_driver'

class Page1 < Page
  def initialize(hash = {})
    super

    create_click_object name: 'Page2',
                        selector: selector_object(type: :link,
                                           specifier: {text: 'Submit2'}),
                        next_page: Page2
  end#initialize
end#Page1

class Page2 < Page
  def initialize(hash = {})
    super
  end#initialize
end#Page2


describe Page do

  before(:all) do
    @browser = WatirDriver.new
    Page.driver = @browser
    Page.page = Page1.new
  end#before all

  after(:all) do
    @browser.send :close
  end#after all

  it '.send(NAME)' do
    expect(Page.page.send('Page2')).to be_instance_of(Elements::ClickElement)
  end#it

  it 'changes pages' do
    @browser.send :goto, "file://#{Dir.pwd}\\spec\\page_object_page_1.html"

    Page.page.send('Page2').send(:click)
    expect(Page.page).to be_instance_of(Page2)
  end#it
end#describe Page