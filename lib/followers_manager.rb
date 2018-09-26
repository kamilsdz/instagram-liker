class FollowersManager < Base
  attr_reader :accepted_followers_range, :max_follow, :sleep_time

  SUGGESTED_PROFILES_URL = 'https://www.instagram.com/explore/people/suggested/'

  def initialize(sleep_time = 2, max_follow = 100, accepted_followers_range = (30..300))
    @max_follow = max_follow
    @sleep_time = sleep_time
    @accepted_followers_range = accepted_followers_range
  end

  def execute
    driver.navigate.to SUGGESTED_PROFILES_URL
    while iterator < max_follow
      elements = driver.find_elements(:xpath, '//div[@role="button"]/a')
      elements.each{ |element| verify_and_follow(element) }
      driver.execute_script('window.scrollBy(0, 1000)')
    end
  rescue Selenium::WebDriver::Error::UnknownError
    driver.execute_script('window.scrollBy(0, 1000)')
    sleep(2)
    retry
  end

  private

  def verify_and_follow(element)
    uri = element.attribute('href')
    return if is_on_clicked_list?(uri)
    add_to_clicked_list(uri) && open_uri_on_new_window(uri)

    follow_button = driver.find_elements(:xpath, '//button[text()="Follow"]')
    (follow_button.first.click; sleep(1); iterator_increase) if account_verified? and !follow_button.empty?
    driver.close
    driver.switch_to.window(driver.window_handles.first)
  end

  def open_uri_on_new_window(uri)
    driver.execute_script('window.open()')
    driver.switch_to.window( driver.window_handles.last )
    driver.get uri
  end

  def account_verified?
    return false if driver.find_elements(:xpath, './/a[contains(@href, "followers")]/span').empty?
    account_followers = driver.find_element(:xpath, './/a[contains(@href, "followers")]/span').attribute('title').sub(',', '').to_i
    accepted_followers_range.include? account_followers
  end

  def clicked_list
    @list ||= []
  end

  def add_to_clicked_list(uri)
    @list << uri
  end

  def is_on_clicked_list?(uri)
    clicked_list.include? uri
  end
end
