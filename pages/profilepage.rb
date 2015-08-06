class ProfilePage < Page
  def initialize(driver)
    @hash_contractor = {}
    super
  end

  # method gets data contractor
  def get_contractor_data
    @hash_contractor = {}
    @hash_contractor[:name]        = @driver.find_element(:css, '.oH1Huge').text
    @hash_contractor[:job]         = @driver.find_element(:css, '.oH2High').text
    @hash_contractor[:description] = @driver.find_element(:css, 'p.notranslate[itemprop="description"]').text.gsub(/\n+/, ' ')
    @hash_contractor[:skills]      = @driver.find_element(:css, '.oExpandableOneLine.oSkills.oExpanded').text.gsub(' less', '')
    @hash_contractor[:hourly_rate] = @driver.find_element(:css, '.oCoinsIcon+.oTxtExtra.ib').text
    @hash_contractor[:rating]      = @driver.find_element(:css, '.oStarIcon+.oTxtExtra.ib').text
    @hash_contractor[:hours]       = @driver.find_element(:css, '.oClockIcon+.oTxtExtra.ib').text.gsub(',', '')
    @hash_contractor[:location]    = @driver.find_element(:css, '.oTxtLrge.ib').text.downcase
    @hash_contractor[:url]         = @driver.current_url
  end

  # method compare contractor data hashes
  def compare_contractor_data(contractor)
    message_good = "Each attribute value is equal to the corresponding attributes of a freelancer #{contractor[:name]} on a profile page:\n#{contractor}"
    message_bad = "Freelancer attribute values ​​not equal to the corresponding attributes in the shared page. Expected:\n#{contractor}\nGot:\n#{@hash_contractor}"
    #hash_contractor = @hash_contractor
    (contractor == @hash_contractor) ? (puts message_good) : (puts message_bad)
  end

  # method checks contractor data by keyword
  def check_contractor_by_keyword(keyword)
    match = @hash_contractor.find do |pair|
      pair.last.downcase.include? keyword.downcase
    end

    (match == nil) ? (puts "#{@hash_contractor[:name]} dont have a #{keyword}") : (puts "The #{keyword} was include in #{match}, #{@hash_contractor[:name]}")
  end


end