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

  describe PageObject::ElementObject do

    before(:each) do
      @browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"
      Page.page = TestPage.new @browser
    end#do

    it '.send(:see)' do
      expect(Page.page.send('Dud').send(:see)).to equal(true)
    end#do

    describe PageObject::ClickElement do

      it '.send(:click)' do
        expect(Page.page.send('Dud').send(:click)).to be_instance_of(Array)
      end#do
    end#ClickElement

    describe PageObject::TextInputElement do

      it ".send(:set, 'text')" do
        expect(Page.page.send('First name').send(:set, 'Test')).to equal(nil)
      end#do

      it '.send(:value)' do
        Page.page.send('First name').send(:set, 'Test')

        expect(Page.page.send('First name').send(:value)).to eq('Test')
      end#do
    end#TextInputElement

    describe PageObject::ListElement do

      it '.send(#).send(:click)' do
        expect(Page.page.send('List1').send(1).send(:click)).to be_instance_of(Array)
      end#do

      it ".send(#).send('name').send(:set, 'text')" do
        expect(Page.page.send('List2').send(0).send('TextField').send(:set, 'Test')).to equal(nil)
      end#do
    end#ListElement

    describe PageObject::CheckboxElement do

      it ".send('name').send(:check)" do
        expect(Page.page.send('I have a bike').send(:check)).to equal(nil)
      end#do
    end#CheckboxElement

    describe PageObject::SaveElement do

      it '.send(:save)' do
        expect(Page.page.send('Reddit').send(:save)).to eq('Reddit')
      end#do

      it '.send(:value)' do
        Page.page.send('Reddit').send(:save)
        expect(Page.page.send('Reddit').send(:value)).to eq('Reddit')
      end#do
    end#SaveElement
  end#ElementObject

  it 'changes pages' do
    @browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    Page.page.send('W3Schools').send(:click)
    expect(Page.page).to be_instance_of(W3Page)
  end#do

end#Page