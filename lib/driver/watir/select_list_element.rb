require_relative '../../../lib/elements/select_list_element'

module Driver::WatirDriver
  class SelectListElement
    def options(driver, *_args)
      #we expect to be returned an Array of the text options
      #so we must take the result which is a WatirDriver wrapper, access the driver
      #which is a WatirCollection, request an array
      #and map the individual options so we can grab the text
      driver.send(params[:actions][:options]).driver.to_a.map {|option| option.text}
    end#options
  end#SelectListElement
end #module Driver::WatirDriver