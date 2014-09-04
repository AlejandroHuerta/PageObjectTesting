require 'rspec'
require_relative '../Driver/watir_driver'
require_relative '../PageObject/page_object'
require_relative 'test_page'


describe PageObject do

  before(:all) do
    @browser = WatirDriver.new
    @page = TestPage.new @browser
  end

  before(:each) do
    @browser.send :goto, "file://#{Dir.pwd}\\TestPage.html"
  end

  after(:all) do
    @browser.send :close
  end

  describe ElementObject do

    describe ClickElement do

      it '.send(:click)' do
        expect(@page.send('W3Schools').send(:click)).to be_instance_of(Array)
      end
    end

    describe TextInputElement do

      it ".send(:set, 'text')" do
        expect(@page.send('First name').send(:set, 'Test')).to equal(nil)
      end

      it '.send(:value)' do
        @page.send('First name').send(:set, 'Test')

        expect(@page.send('First name').send(:value)).to eq('Test')
      end
    end

    describe ListElement do

      it '.send(#).send(:click)' do
        expect(@page.send('List1').send(1).send(:click)).to be_instance_of(Array)
      end

      it ".send(#).send('name').send(:set, 'text')" do
        expect(@page.send('List2').send(0).send('TextField').send(:set, 'Test')).to equal(nil)
      end
    end

    describe CheckboxElement do

      it ".send('name').send(:check)" do
        expect(@page.send('I have a bike').send(:check)).to equal(nil)
      end
    end

    describe SaveElement do

      it '.send(:save)' do
        expect(@page.send('Reddit').send(:save)).to eq('Reddit')
      end

      it '.send(:value)' do
        @page.send('Reddit').send(:save)
        expect(@page.send('Reddit').send(:value)).to eq('Reddit')
      end
    end
  end
end