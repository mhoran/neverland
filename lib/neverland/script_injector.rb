module Neverland
  class ScriptInjector
    def self.inject(response, params)
      new(response).inject(params)
    end

    def initialize(response)
      case response
      when ActionDispatch::Response
        @injector = ActionDispatchScriptInjector.new(response)
      else
        @injector = NullScriptInjector.new(response)
      end
    end

    def inject(params)
      @injector.inject(params)
    end
  end

  class ActionDispatchScriptInjector
    def initialize(response)
      @response = response
      @document = Nokogiri::HTML(@response.body)
      @head = @document.at('head')
    end

    def inject(params)
      if @head
        inject_script(:src => '/javascripts/neverland.js')

        if params.error_code
          inject_script(:body => <<SCRIPT)
Neverland.setError(#{params.error_code})
SCRIPT
        elsif params.latitude && params.longitude
          inject_script(:body => <<SCRIPT)
Neverland.setLatitude(#{params.latitude})
Neverland.setLongitude(#{params.longitude})
SCRIPT
        end

        @response.body = @document.to_s
      end

      @response
    end

    private

    def inject_script(opts = {})
      script = Nokogiri::XML::Node.new('script', @document)
      script['type'] = 'text/javascript'
      script['src'] = opts[:src] if opts[:src]
      script.inner_html = opts[:body] if opts[:body]
      @head << script
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
