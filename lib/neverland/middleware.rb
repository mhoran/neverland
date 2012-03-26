require 'nokogiri'

module Neverland
  class Middleware
    def initialize(app)
      @app = app
    end

    def call(env)
      parameters = ParameterExtractor.extract(env)

      status, headers, response = @app.call(env)

      response = ScriptInjector.inject(response, parameters)

      [status, headers, response]
    end
  end
end
