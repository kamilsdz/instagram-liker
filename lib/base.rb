class Base

  SIGN_IN_URL = 'https://www.instagram.com/accounts/login/?source=auth_switcher'

  def prepare
    driver.navigate.to SIGN_IN_URL
  end

  private

  def iterator
    @i ||= 0
  end

  def iterator_increase
    @i += 1
    puts "Iteration: #{@i}"
  end

  def driver
    @driver ||= ChromeDriver.new.driver
  end
end