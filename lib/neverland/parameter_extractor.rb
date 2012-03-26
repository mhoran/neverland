module Neverland
  class ParameterExtractor
    def self.extract(env)
      new(env).extract
    end

    def initialize(env)
      @request = Rack::Request.new(env)
    end

    def extract
      Parameters.new(latitude, longitude, error_code)
    end

    private

    def params
      @request.params
    end

    def neverland_params
      params['neverland'] || {}
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

  class Parameters
    attr_reader :latitude, :longitude, :error_code

    def initialize(latitude = nil, longitude = nil, error_code = nil)
      @latitude = latitude
      @longitude = longitude
      @error_code = error_code
    end
  end
end
