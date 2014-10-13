require 'rspec'
require_relative '../PageObject/page_object'
require_relative '../Driver/rautomation_driver'
require_relative '../PageObject/page'

class Page1 < Page
  def initialize(driver)

  end
end

describe PageObject::ElementObject do

  before(:all) do
    native_driver = RAutomation::Window.new title: 'MainFormWindow'
    @driver = RAutomationDriver.new native_driver
  end

  it '.send(:see)' do
    e = PageObject::ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: PageObject::Selector.new(type: :button,
                                                                         locator: {value: 'Enabled'})

    expect(e.send(:see)).to equal(true)
  end#do

  describe PageObject::ClickElement do

    it '.send(:click)' do
      e = PageObject::ClickElement.new driver: @driver,
                                       name: 'name',
                                       selector: PageObject::Selector.new(type: :button,
                                                                          locator: {value: 'Enabled'})

      expect(e.send(:click)).to equal(true)
    end#do
  end#ClickElement

  describe PageObject::TextInputElement do

    it '.send(:set, TEXT)' do
      e = PageObject::TextInputElement.new driver: @driver,
                                          name: 'name',
                                          selector: PageObject::Selector.new(type: :text_field,
                                                                             locator: {class: /Edit/i, index: 2})

      expect(e.send(:set, 'Something')).to equal(true)
    end#do

    it '.send(:value)' do
      e = PageObject::TextInputElement.new driver: @driver,
                                           name: 'name',
                                           selector: PageObject::Selector.new(type: :text_field,
                                                                              locator: {class: /Edit/i, index: 2})

      e.send(:set, 'Something')
      expect(e.send(:value)).to eq('Something')
    end
  end#TextInputElement
end#ElementObject