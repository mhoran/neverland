module Neverland
  class ParameterExtractor
    def self.extract(env)
      new(env).extract
    end

    def initialize(env)
      @request = Rack::Request.new(env)
    end

    def extract
      if neverland_params
        [latitude, longitude, error_code]
      end
    end

    private

    def params
      @request.params
    end

    def neverland_params
      params['neverland']
    end

    def latitude
      neverland_params['latitude']
    end

    def longitude
      neverland_params['longitude']
    end

    def error_code
      neverland_params['error_code']
    end
  end
end
