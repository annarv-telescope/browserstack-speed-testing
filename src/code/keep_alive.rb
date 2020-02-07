module Selenium
  module WebDriver
    module Remote
      module Http
        class KeepAlive < Default
          def close
            super
            @http.finish if @http&.started?
          end

          private

          def http
            super.tap do |http|
              http.start unless http.started?
            end
          end
        end # KeepAlive
      end # Http
    end # Remote
  end # WebDriver
end # Selenium

