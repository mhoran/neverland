require 'nokogiri'

module Neverland
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      params = Rack::Request.new(env).params
      if params['neverland']
        error = params['neverland']['error_code']
        latitude = params['neverland']['latitude']
        longitude = params['neverland']['longitude']
      end

      status, headers, response = @app.call(env)

      case response
      when ActionDispatch::Response
        document = Nokogiri::HTML(response.body)
        head = document.at('head')

        script = Nokogiri::XML::Node.new('script', document)
        script['type'] = 'text/javascript'
        script['src'] = '/javascripts/neverland.js'
        head << script

        if error
          script = Nokogiri::XML::Node.new('script', document)
          script['type'] = 'text/javascript'
          script.inner_html = <<SCRIPT
Neverland.setError(#{error})
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

      [status, headers, response]
    end
  end
end
