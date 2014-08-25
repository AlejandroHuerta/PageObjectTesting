require_relative 'watir_driver'
require_relative 'page_object'

class Page
  include PageObject

  def initialize(_driver)
    super

    create_click_object 'Search', selector(:button, {:id => 'gbqfb'})
    create_text_field 'Search Bar', selector(:text_field, {:id => 'gbqfq'})
    create_list 'Results', selector(:div, {:id => 'ires'}), click_object('Result', selector(:link, {}))
  end
end

driver = WatirDriver.new
driver.send :goto, 'www.google.com'

p = Page.new(driver)
p.send('Search Bar').send(:set, "#{(Random.rand * 100).to_i} kilometers to miles")
p.send('Search').send(:click)

p.send('Results').send(1).send(:click)