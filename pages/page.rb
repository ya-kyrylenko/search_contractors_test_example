class Page
  def initialize(driver)
    @driver = driver

  end

  def expand_more_information
    buttons = @driver.find_elements(:css, '.oMore')
    buttons.each do |but|
      but.click
    end

    buttons = @driver.find_elements(:css, '.oExpandText')
    buttons.each do |but|
      but.click
    end
  end

  def close
    @driver.close
  end
end