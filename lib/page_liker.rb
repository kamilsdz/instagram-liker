class PageLiker < Base
  attr_reader :max_liked_items, :sleep_time

  HOME_URL = 'https://www.instagram.com'

  def initialize(sleep_time = 2, max_liked_items = 100)
    @max_liked_items = max_liked_items
    @sleep_time = sleep_time
  end

  def execute
    driver.navigate.to HOME_URL
    while iterator < max_liked_items
      elements = driver.find_elements(:xpath, '//span[@aria-label="Like"]')
      elements.each{ |element| element.click; iterator_increase; sleep(sleep_time) }
      driver.execute_script('window.scrollBy(0, 1000)')
    end
  rescue Selenium::WebDriver::Error::UnknownError
    driver.execute_script('window.scrollBy(0, 1000)')
    retry
  end
end
