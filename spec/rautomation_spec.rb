require 'rspec'
require_relative '../lib/driver/rautomation_driver'
require_relative '../lib/page_object/page'

class Page1 < Page
  def initialize(hash)

  end
end

include Elements

describe ElementObject do

  before(:all) do
    native_driver = RAutomation::Window.new title: 'MainFormWindow'
    @driver = RAutomationDriver.new native_driver
  end

  it '.send(:see)' do
    e = ElementObject.new driver: @driver,
                                      name: 'name',
                                      selector: Selector.new(type: :button,
                                                                         specifier: {value: 'Enabled'})

    expect(e.send(:see)).to equal(true)
  end#do

  describe ClickElement do

    it '.send(:click)' do
      e = ClickElement.new driver: @driver,
                                       name: 'name',
                                       selector: Selector.new(type: :button,
                                                                          specifier: {value: 'Enabled'})

      expect(e.send(:click)).to equal(true)
    end#do

    it '.send(:click) with custom confirmation block' do
      checker = ElementObject.new driver: @driver,
                                              name: 'name',
                                              selector: Selector.new(type: :button,
                                                                                 specifier: {value: 'Reset'})

      e = ClickElement.new driver: @driver,
                                       name: 'name',
                                       selector: Selector.new(type: :button,
                                                                          specifier: {value: 'Enabled'}),
                                       block: Proc.new {checker.send(:see)}

      expect(e.send(:click)).to equal(true)
    end#do
  end#ClickElement

  describe TextInputElement do

    it '.send(:set, TEXT)' do
      e = TextInputElement.new driver: @driver,
                                          name: 'name',
                                          selector: Selector.new(type: :text_field,
                                                                             specifier: {class: /Edit/i, index: 2})

      expect(e.send(:set, 'Something')).to equal(true)
    end#do

    it '.send(:value)' do
      e = TextInputElement.new driver: @driver,
                                           name: 'name',
                                           selector: Selector.new(type: :text_field,
                                                                              specifier: {class: /Edit/i, index: 2})

      e.send(:set, 'Something')
      expect(e.send(:value)).to eq('Something')
    end
  end#TextInputElement
end#ElementObject