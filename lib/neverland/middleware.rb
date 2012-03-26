require 'nokogiri'

module Neverland
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      latitude, longitude, error_code = ParameterExtractor.extract(env)

      status, headers, response = @app.call(env)

      case response
      when ActionDispatch::Response
        document = Nokogiri::HTML(response.body)
        head = document.at('head')

        if head
          script = Nokogiri::XML::Node.new('script', document)
          script['type'] = 'text/javascript'
          script['src'] = '/javascripts/neverland.js'
          head << script

          if error_code
            script = Nokogiri::XML::Node.new('script', document)
            script['type'] = 'text/javascript'
            script.inner_html = <<SCRIPT
Neverland.setError(#{error_code})
SCRIPT
            head << script
          elsif latitude && longitude
            script = Nokogiri::XML::Node.new('script', document)
            script['type'] = 'text/javascript'
            script.inner_html = <<SCRIPT
Neverland.setLatitude(#{latitude})
Neverland.setLongitude(#{longitude})
SCRIPT
            head << script
          end

          response.body = document.to_s
        end
      end

      [status, headers, response]
    end
  end
end
