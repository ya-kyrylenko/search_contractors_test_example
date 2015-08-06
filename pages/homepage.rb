class HomePage < Page
  def initialize(driver)
    super
  end

  # method clear cookies and go to url
  def get_home_page(url)
    @driver.manage.delete_all_cookies
    @driver.get(url)
  end

  # method fills keyword in search field
  def find_contractors_by_keyword(keyword)
    element = @driver.find_element :name => "q"
    element.send_keys keyword
    element.submit
  end
end