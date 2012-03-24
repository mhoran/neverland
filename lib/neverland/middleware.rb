require 'nokogiri'

module Neverland
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      cookies = Rack::Request.new(env).cookies
      latitude = cookies['mock_latitude']
      longitude = cookies['mock_longitude']

      status, headers, response = @app.call(env)

      case response
      when ActionDispatch::Response
        document = Nokogiri::HTML(response.body)
        head = document.at('head')

        script = Nokogiri::XML::Node.new('script', document)
        script['type'] = 'text/javascript'
        script['src'] = '/javascripts/neverland.js'
        head << script

        if latitude.present? && longitude.present?
          script = Nokogiri::XML::Node.new('script', document)
          script['type'] = 'text/javascript'
          script.inner_html = <<-SCRIPT
            Neverland.setLatitude(#{latitude})
            Neverland.setLongitude(#{longitude})
          SCRIPT
          head << script
        end

        response.body = document.to_s
      end

      [status, headers, response]
    end
  end
end
