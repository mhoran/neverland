module Neverland
  class ScriptInjector
    def self.inject(response, parameters)
      new(response).inject(parameters)
    end

    def initialize(response)
      case response
      when ActionDispatch::Response
        @injector = ActionDispatchScriptInjector.new(response)
      else
        @injector = NullScriptInjector.new(response)
      end
    end

    def inject(parameters)
      @injector.inject(parameters)
    end
  end

  class ActionDispatchScriptInjector
    def initialize(response)
      @response = response
    end

    def inject(parameters)
      latitude, longitude, error_code = parameters

      if head
        inject_script(:src => '/javascripts/neverland.js')

        if error_code
          inject_script(:body => <<SCRIPT)
Neverland.setError(#{error_code})
SCRIPT
        elsif latitude && longitude
          inject_script(:body => <<SCRIPT)
Neverland.setLatitude(#{latitude})
Neverland.setLongitude(#{longitude})
SCRIPT
        end

        @response.body = document.to_s
      end

      @response
    end

    private

    def document
      @document ||= Nokogiri::HTML(@response.body)
    end

    def head
      @head ||= document.at('head')
    end

    def inject_script(opts = {})
      script = Nokogiri::XML::Node.new('script', document)
      script['type'] = 'text/javascript'
      script['src'] = opts[:src] if opts[:src]
      script.inner_html = opts[:body] if opts[:body]
      head << script
    end
  end

  class NullScriptInjector
    def initialize(response)
      @response = response
    end

    def inject(_)
      @response
    end
  end
end
