require 'rspec'
require_relative '../Driver/watir_driver'
require_relative 'w3_page'
require_relative 'test_page'


describe Page do

  before(:all) do
    @browser = WatirDriver.new
    Page.page = TestPage.new @browser
  end

  after(:all) do
    @browser.send :close
  end

  describe ElementObject do

    before(:each) do
      @browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"
      Page.page = TestPage.new @browser
    end

    describe ClickElement do

      it '.send(:click)' do
        expect(Page.page.send('Dud').send(:click)).to be_instance_of(Array)
      end
    end

    describe TextInputElement do

      it ".send(:set, 'text')" do
        expect(Page.page.send('First name').send(:set, 'Test')).to equal(nil)
      end

      it '.send(:value)' do
        Page.page.send('First name').send(:set, 'Test')

        expect(Page.page.send('First name').send(:value)).to eq('Test')
      end
    end

    describe ListElement do

      it '.send(#).send(:click)' do
        expect(Page.page.send('List1').send(1).send(:click)).to be_instance_of(Array)
      end

      it ".send(#).send('name').send(:set, 'text')" do
        expect(Page.page.send('List2').send(0).send('TextField').send(:set, 'Test')).to equal(nil)
      end
    end

    describe CheckboxElement do

      it ".send('name').send(:check)" do
        expect(Page.page.send('I have a bike').send(:check)).to equal(nil)
      end
    end

    describe SaveElement do

      it '.send(:save)' do
        expect(Page.page.send('Reddit').send(:save)).to eq('Reddit')
      end

      it '.send(:value)' do
        Page.page.send('Reddit').send(:save)
        expect(Page.page.send('Reddit').send(:value)).to eq('Reddit')
      end
    end
  end

  it 'changes pages' do
    @browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"

    Page.page.send('W3Schools').send(:click)
    expect(Page.page).to be_instance_of(W3Page)
  end

end