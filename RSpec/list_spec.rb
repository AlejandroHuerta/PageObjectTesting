require 'rspec'
require_relative '../watir_driver'
require_relative '../page_object'
require_relative 'test_page'

browser = WatirDriver.new
page = TestPage.new browser

describe ClickObject do
  browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

  it 'should click the link Google' do
    page.send('W3Schools').send(:click)
  end
end

describe ListObject do
  browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

  it 'should manipulate list' do
    page.send('List1').send(1).send(:click)
  end

  it 'should be able to select which child to pass the action to' do
    page.send('List2').send(0).send('TextField').send(:set, 'Test')
  end
end

describe CheckboxObject do
  browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

  it 'should check and then uncheck a box' do
    page.send('I have a bike').send(:check)
    expect(page.send('I have a bike').send(:checked?)).to equal(true)
  end
end