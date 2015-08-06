class ResultPage < Page

  def initialize(driver)
    super
    @my_array = []

  end

  # method checks contractor's data by keyword(it should be included in some field of contractor data)
  def check_contractors_by_keyword(keyword)

    contractors = @driver.find_elements(:css, '.oSearchResultItem')
    contractors.each do |contractor|
      my_hash = {}

      my_hash[:name] =             contractor.find_element(:css, '.notranslate').text
      my_hash[:job] =              contractor.find_element(:css, 'h3.oAutoWrap.oContractorTagline.notranslate').text
      my_hash[:description] =      contractor.find_element(:css, '.oArticleBody>.oContractorDescription').text.gsub('  less', '')
      my_hash[:skills] =           contractor.find_element(:css, '.oExpandableOneLine.oSkills').text.gsub(' less', '')
      my_hash[:hourly_rate] =      contractor.find_element(:css, 'SPAN.oFact.oRate').text
      my_hash[:rating] =           contractor.find_element(:css, '.oStars.oStarsSmall').attribute('oldtitle').gsub(' Stars', '')
      my_hash[:hours] =            contractor.find_element(:css, 'SPAN.oFact.oHrs.notranslate').text
      my_hash[:location] =         contractor.find_element(:css, 'SPAN.oLocation').text.downcase
      my_hash[:url] =              contractor.find_element(:css, '.oLoadContractor').attribute('href')

      match = my_hash.find do |pair|
        pair.last.downcase.include? keyword.downcase
      end

      (match == nil) ? (puts "#{my_hash[:name]} dont have a #{keyword}") : (puts "The #{keyword} was include in #{match}, #{my_hash[:name]}")
      @my_array << my_hash
    end

  end

# selects a random contractor
  def go_to_random_contractor
    contractor = @my_array.sample
    @driver.get contractor[:url]
    contractor
  end

end