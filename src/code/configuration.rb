require 'config'

module Configuration

  BS_USER = ENV['BS_USER']
  BS_PASSWORD = ENV['BS_PASSWORD']
  raise('Browserstack credentials are missing') unless BS_USER && BS_PASSWORD

  BROWSERSTACK = ENV['BS'] || false


  BROWSER_WIDTH = ENV['BROWSER_WIDTH'] || '1920'
  BROWSER_HEIGHT = ENV['BROWSER_HEIGHT'] || '1080'

  BROWSER = ENV['BROWSER'] || 'Chrome'
  BROWSER_FULL_NAME = case BROWSER
                      when 'Chrome' then
                        :chrome
                      when 'ChromeHeadless' then
                        :chromeheadless
                      end

end # Configuration

