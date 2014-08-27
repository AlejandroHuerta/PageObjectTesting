require 'rspec'
require_relative '../Driver/watir_driver'
require_relative '../PageObject/page_object'
require_relative 'test_page'

browser = WatirDriver.new
page = TestPage.new browser

describe ClickElement do

  it '.click' do
    browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    expect(page.send('W3Schools').send(:click)).to be_instance_of(Array)
  end
end

describe TextInputElement do

  it '.set text' do
    browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    expect(page.send('First name').send(:set, 'Test')).to equal(nil)
  end

  it '.text' do
    browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    page.send('First name').send(:set, 'Test')

    expect(page.send('First name').send(:text)).to eq('Test')
  end
end

describe ListElement do

  it '.#.click' do
    browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    expect(page.send('List1').send(1).send(:click)).to be_instance_of(Array)
  end

  it '.#.name.set text' do
    browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    expect(page.send('List2').send(0).send('TextField').send(:set, 'Test')).to equal(nil)
  end
end

describe CheckboxElement do

  it '.name.check' do
    browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    expect(page.send('I have a bike').send(:check)).to equal(nil)
  end
end

describe SaveElement do

  it '.save' do
    browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    page.send('Reddit').send(:save)
  end
end