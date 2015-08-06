# class saves variables to start the test
class TestConfig
  attr_reader :keyword, :browser

  def initialize(path)
    config = File.open(path){ |file| file.read.split("\n") }
    (config[0].split(': ').first == 'keyword') ? (keyword = config[0].split(': ').last) : (raise 'Incorrect keyword')
    (config[1].split(': ').first == 'browser') ? (browser = config[1].split(': ').last) : (raise 'Incorrect browser')
    raise 'You must specify keyword in config.txt' unless keyword != nil
    raise 'You must specify browser in config.txt' unless browser != nil
    @keyword = keyword
    @browser = browser
  end

end