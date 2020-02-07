
module Browser
  class << self
    attr_accessor :all, :current, :defaultScope

    def open()
      if Configuration::BROWSER_FULL_NAME == :chromeheadless
      resolution = '--window-size=' + Configuration::BROWSER_WIDTH + ',' + Configuration::BROWSER_HEIGHT
      self.current = Watir::Browser.new :chrome, switches: %W[
            --ignore-certificate-errors
            --disable-popup-blocking
            --disable-translate
            --disable-notifications
            --start-maximized
            #{resolution}
            --disable-gpu
            --headless
          ]
      else
        driver = Selenium::WebDriver.for :chrome
        self.current = Watir::Browser.new driver
        current.window.resize_to Configuration::BROWSER_WIDTH, Configuration::BROWSER_HEIGHT
        current.window.move_to 0, 0
      end
      self.all ||= []
      self.all << current
    end

    def open_in_browserstack(**args)
      http_client = Selenium::WebDriver::Remote::Http::KeepAlive.new
      caps = Selenium::WebDriver::Remote::Capabilities.new
      caps['browser'] = args[:browser]
      caps['browser_version'] = args[:browser_version]
      caps['os'] = args[:os]
      caps['os_version'] = args[:os_version]

      self.current = Watir::Browser.new(
        :remote,
        url: "http://#{Configuration::BS_USER}:#{Configuration::BS_PASSWORD}@hub.browserstack.com/wd/hub",
          desired_capabilities: caps, http_client: http_client
      )
      self.all ||= []
      self.all << current
    end

    def close
      self.all -= [current]
      current.close
      self.current = all.last if all.any?
    end

  end # class
end # Browser


