require 'selenium-webdriver'

class ChromeDriver
  attr_accessor :options

  def initialize(options = ['--ignore-certificate-errors', '--disable-popup-blocking', '--disable-translate'])
    @options = options
  end

  def driver
    @driver ||= setup_driver
  end

  private

  def setup_driver
    driver = Selenium::WebDriver.for :chrome, options: selenium_options
    driver.manage.window.resize_to(800, 800)
    return driver
  end

  def selenium_options
    selenium_options = Selenium::WebDriver::Chrome::Options.new
    options.each{ |option| selenium_options.add_argument(option) }
    return selenium_options
  end
end

