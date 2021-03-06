require_relative '../lib/driver/watir_driver'
require_relative '../lib/elements/checkbox_element'
require_relative '../lib/elements/click_element'
require_relative '../lib/elements/element_object'
require_relative '../lib/elements/list_element'
require_relative '../lib/elements/save_element'
require_relative '../lib/elements/selector'
require_relative '../lib/elements/text_input_element'
require_relative '../lib/elements/select_list_element'
require_relative '../lib/elements/key_sequence_element'

describe ElementObject do

  before(:all) do
    @driver = WatirDriver.new
  end

  after(:all) do
    @driver.send :close
  end

  before(:each) do
    @driver.send :goto, "file://#{Dir.pwd}\\spec\\page_object_page_1.html"
  end#do

  it '.send(:see)' do
    e = ElementObject.new driver: @driver,
                                  name: 'name',
                                  selector: Selector.new(type: :button,
                                                         specifier: {id: 'form2button'})

    expect(e.send(:see)).to equal(true)
  end#do

  context 'added action' do

    it '.send(:hover)' do
      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(type: :button,
                                                   specifier: {id: 'hover_target'}),
                            actions: {hover: :hover}

      f = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(type: :span,
                                                   specifier: {id: 'hover_text'}),
                            actions: {text: :text}

      expect(e.send(:hover)).to equal(nil)
      expect(f.send(:text)).to eq('Hover Target - Success')
    end#it
  end#context

  context 'multiple selectors' do

    it '.send(:text) on item with multiple selectors' do
      e = ElementObject.new driver: @driver,
                                    name: 'name',
                                    selector: [Selector.new(type: :element,
                                                            specifier: {text: 'Deep child in list'}),
                                               Selector.new(type: :parent),
                                               Selector.new(type: :parent)],
                                    actions: {text: :text}

      expect(e.send(:text)).to include('Element 1')
    end#it
  end#context

  it '.send(:see_text_as, TEXT)' do
    e = ElementObject.new driver: @driver,
                          name: 'name',
                          selector: Selector.new(type: :element,
                                                 specifier: {id: 'element2'}),
                          actions: {see_text_as: :see_text_as}

    expect(e.send(:see_text_as, 'Fake Element 2')).to equal(true)
  end

  context 'selector with no type specified' do

    it '.send(:see)' do
      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(specifier: {id: 'element2'})

      expect(e.send(:see)).to equal(true)
    end#it
  end#context

  context 'before block is ran' do

    it '.send(:see)' do
      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(specifier: {id: 'decorator_test_li_2'}),
                            before: proc {|driver| driver.send(:style).match(/blue/)}

      expect(e.send(:see)).to equal(false)

      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(specifier: {id: 'decorator_test_li_2'}),
                            before: proc {|driver| driver.send(:style).match('color: green')}

      expect(e.send(:see)).to equal(true)
    end#it

    it '.send(NAME).send(:see)' do
      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(type: :li,
                                                   specifier: {id: 'decorator_test_li_2'}),
                            children: ElementObject.new(driver: @driver,
                                                        name: 'Highlighted',
                                                        before: proc {|driver| driver.send(:style).match(/green/)})

      expect(e.send('Highlighted').send(:see)).to equal(true)
    end#it
  end#context

  context 'searching by css' do
    it '.send(:see)' do
      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(type: :li,
                                                   specifier: {css: 'li[style="color:green"]'})

      expect(e.send(:see)).to equal(true)

      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(type: :li,
                                                   specifier: {css: 'li[style="color:red"]'})

      expect(e.send(:see)).to equal(false)
    end#it

    it '.send(NAME).send(:see)' do
      e = ElementObject.new driver: @driver,
                            name: 'name',
                            selector: Selector.new(type: :li,
                                                   specifier: {id: 'decorator_test_li_2'}),
                            children: ElementObject.new(driver: @driver,
                                                        name: 'Highlighted',
                                                        selector: [Selector.new(type: :parent),
                                                                   Selector.new(type: :li,
                                                                                specifier: {css: 'li[style="color:green"]'})])

      expect(e.send('Highlighted').send(:see)).to equal(true)
    end#it
  end#context

  describe ClickElement do

    it '.send(:click)' do
      e = ClickElement.new driver: @driver,
                           name: 'name',
                           selector: Selector.new(type: :button,
                                                  specifier: {id: 'form2button'})

      expect(e.send(:click)).to be_instance_of(Array)
    end#do

    context 'driver added method is called' do

      it '.send(:click) driver added method is called' do
        e = ClickElement.new driver: @driver,
                             name: 'name',
                             selector: Selector.new(type: :button,
                                                    specifier: {id: 'form2button'}),
                             actions: {click: :on_mouse_down}

        expect(e.send(:click)).to equal(true)
      end#it
    end#context
  end#ClickElement

  describe TextInputElement do

    it '.send(:set, TEXT)' do
      e = TextInputElement.new driver: @driver,
                               name: 'First name',
                               selector: Selector.new(type: :text_field,
                                                      specifier: {id: 'email'})


      expect(e.send(:set, 'Test')).to equal(nil)
    end#do

    it '.send(:value)' do
      e = TextInputElement.new driver: @driver,
                               name: 'First name',
                               selector: Selector.new(type: :text_field,
                                                      specifier: {id: 'email'})

      e.send(:set, 'Test')
      expect(e.send(:value)).to eq('Test')
    end#do
  end#TextInputElement

  describe ListElement do

    context 'action pass through' do

      it '.send(#).send(:click)' do
        e = ListElement.new driver: @driver,
                            name: 'List1',
                            selector: Selector.new(type: :form,
                                                   specifier: {id: 'form'}),
                            children: [ClickElement.new(driver: @driver,
                                                        name: 'Link',
                                                        selector: Selector.new(type: :a)),
                                       TextInputElement.new(driver: @driver,
                                                            name: 'TextField',
                                                            selector: Selector.new(type: :text_field))]

        expect(e.send(1).send(:click)).to be_instance_of(Array)
      end#do
    end#context

    it '.send(#).send(NAME).send(:set, TEXT)' do
      e = ListElement.new driver: @driver,
                          name: 'List2',
                          selector: Selector.new(type: :form,
                                                 specifier: {id: 'form'}),
                          children: [ClickElement.new(driver: @driver,
                                                      name: 'Link',
                                                      selector: Selector.new(type: :a)),
                                     TextInputElement.new(driver: @driver,
                                                          name: 'TextField',
                                                          selector: Selector.new(type: :text_field))]

      expect(e.send(0).send('TextField').send(:set, 'Test')).to equal(nil)
    end#do
  end#ListElement

  describe CheckboxElement do

    it '.send(NAME).send(:check)' do
      e =  CheckboxElement.new driver: @driver,
                               name: 'name',
                               selector: Selector.new(type: :checkbox,
                                                      specifier: {name: 'checkboxtest1'})

      expect(e.send(:check)).to equal(nil)
    end#do
  end#CheckboxElement

  describe SaveElement do

    it '.send(:save)' do
      e = SaveElement.new driver: @driver,
                          name: 'name',
                          selector: Selector.new(type: :li,
                                                 specifier: {id: 'element2'}),
                          actions: {save: :text}

      expect(e.send(:save)).to eq('Fake Element 2')
    end#do

    it '.send(:value)' do
      e = SaveElement.new driver: @driver,
                          name: 'name',
                          selector: Selector.new(type: :li,
                                                 specifier: {id: 'element2'}),
                          actions: {save: :text}

      e.send(:save)
      expect(e.send(:value)).to eq('Fake Element 2')
    end#do
  end#SaveElement

  describe SelectListElement do
    it '.send(:select, OPTION)' do
      e = SelectListElement.new driver: @driver,
                               name: 'NAME',
                               selector: Selector.new(type: :select_list,
                                                      specifier: {id: 'select_test'})

      expect(e.send(:select, 'second 2nd')).to eql 'second 2nd'
    end#it

    it '.send(:options)' do
      e = SelectListElement.new driver: @driver,
                                name: 'NAME',
                                selector: Selector.new(type: :select_list,
                                                       specifier: {id: 'select_test'})

      expect(e.send(:options)).to eql ['first 1st', 'second 2nd', 'third 3rd', 'fourth 4th', 'fifth 5th']
    end#it
  end#SelectListElement

  describe KeySequenceElement do

    it '.send(:enter)' do
      d = TextInputElement.new driver: @driver,
                               name: 'First name',
                               selector: Selector.new(type: :text_field,
                                                      specifier: {id: 'email'}),
                               actions: {click: :click}

      d.send(:click)

      e = KeySequenceElement.new driver: @driver,
                                 name: 'NAME',
                                 keys: [[:shift, 'a'], 'b']

      expect(e.send(:enter)).to eql nil
      expect(d.send(:text)).to eql 'Ab'
    end

    it '.send(:do)' do
      d = TextInputElement.new driver: @driver,
                               name: 'First name',
                               selector: Selector.new(type: :text_field,
                                                      specifier: {id: 'email'}),
                               actions: {click: :click}

      d.send(:click)

      e = KeySequenceElement.new driver: @driver,
                                 name: 'NAME',
                                 keys: [[:shift, 'b'], 'a']

      expect(e.send(:do)).to eql nil
      expect(d.send(:text)).to eql 'Ba'
    end
  end
end#ElementObject