require 'rspec'
require_relative '../lib/page_object/page_factory'
require_relative '../lib/page_object/page'
require_relative '../lib/driver/automation_driver'
require_relative '../lib/page_object/page_builder/page_builder'
require_relative '../lib/page_object/page_builder/click_builder'

include PageObject

class Page1 < Page
  def initialize
    super

    create_click_object name: 'Page2',
                        selector: selector(type: :link,
                                           specifier: {text: 'Submit2'}),
                        next_page: 'Page2'
  end#initialize
end#Page1

class Page2 < Page
  def initialize
    super

    create_click_object name: 'Page1',
                        selector: selector(type: :link,
                                           specifier: {text: 'Submit2'}),
                        next_page: 'Page1'
  end#initialize
end#Page2

class DummyDriver
  def link(*_args)
    self
  end

  def method_missing(_method, *_args, &_block)
    true
  end
end

class DummyWrapper < AutomationDriver
  def process_result(result)
    DummyWrapper.new result
  end
end

Page.driver = DummyWrapper.new DummyDriver.new

describe PageFactory do

  it 'contain an added page' do
    PageFactory.instance.add_page 'Page1', Page1.new

    expect(PageFactory.instance.get_page('Page1')).to be_instance_of(Page1)
  end

  it 'modifies Page to return the next page' do
    PageFactory.instance.add_page 'Page1', Page1.new
    PageFactory.instance.add_page 'Page2', Page2.new

    Page.page = PageFactory.instance.get_page 'Page1'
    Page.page.send('Page2').send(:click)

    expect(Page.page).to be_instance_of Page2

    Page.page.send('Page1').send(:click)

    expect(Page.page).to be_instance_of Page1
  end

  it 'contains dsl created pages' do
    PageBuilder::PageBuilder.page 'Page3' do
      click 'Page4' do
        next_page 'Page4'
      end
    end

    PageBuilder::PageBuilder.page 'Page4' do
      click 'Page3' do
        next_page 'Page3'
      end
    end

    Page.page = PageFactory.instance.get_page 'Page3'

    Page.page.send('Page4').send(:click)

    expect(Page.page.params[:name]).to eq 'Page4'

    Page.page.send('Page3').send(:click)

    expect(Page.page.params[:name]).to eq 'Page3'
  end
end