class PageLiker
  attr_reader :max_liked_items, :sleep_time

  SIGN_IN_URL = 'https://www.instagram.com/accounts/login/?source=auth_switcher'
  HOME_URL = 'https://www.instagram.com'

  def initialize(sleep_time = 2, max_liked_items = 100)
    @max_liked_items = max_liked_items
    @sleep_time = sleep_time
  end

  def prepare
    driver.navigate.to SIGN_IN_URL
  end

  def execute
    driver.navigate.to HOME_URL
    while iterator < max_liked_items
      elements = driver.find_elements(:xpath, '//span[@aria-label="Like"]')
      elements.each{ |element| element.click; iterator_increase }
      driver.execute_script('window.scrollBy(0, 1000)')
    end
  rescue Selenium::WebDriver::Error::UnknownError
    driver.execute_script('window.scrollBy(0, 1000)')
    retry
  end

  private

  def iterator
    @i ||= 0
  end

  def iterator_increase
    @i += 1
  end

  def driver
    @driver ||= ChromeDriver.new.driver
  end
end
