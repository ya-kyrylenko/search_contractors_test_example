require 'selenium-webdriver'
require './pages/page.rb'
require './pages/resultpage.rb'
require './pages/homepage.rb'
require './pages/profilepage.rb'
require './testconfig.rb'


begin

  puts 'Get into config values <keyword> and <browser> from config.txt'
  config = TestConfig.new('config.txt')
  puts "Run a #{config.browser}"
  driver = Selenium::WebDriver.for config.browser.to_sym
  driver.manage.timeouts.implicit_wait = 10
  page = HomePage.new(driver)
  puts 'Open home page: http://www.odesk.com'
  page.get_home_page("http://www.odesk.com")
  puts "Enter in the search #{config.keyword}"
  page.find_contractors_by_keyword(config.keyword)
  page = ResultPage.new(driver)
  puts 'Click on the buttons <More>'
  page.expand_more_information
  puts "Check each user to the presence #{config.keyword}"
  page.check_contractors_by_keyword(config.keyword)
  puts 'Go to the random contractor page'
  contractor = page.go_to_random_contractor
  page = ProfilePage.new(driver)
  puts 'Click on the buttons <More>'
  page.expand_more_information
  puts 'Get contractor\'s data on the current page'
  page.get_contractor_data
  puts "Checking whether at least one attribute #{config.keyword}"
  page.check_contractor_by_keyword(config.keyword)
  puts 'Compare current data with data from previous page of the current contractor'
  page.compare_contractor_data(contractor)
  puts "Close #{config.browser}"
  page.close

ensure
  driver.quit unless driver.nil?
end