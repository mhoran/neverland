require 'spec_helper'

module Neverland
  describe ParameterExtractor do
    describe '.extract' do
      let(:latitude) { '42.31283' }
      let(:longitude) { '-71.114287' }
      let(:error_code) { '3' }
      let(:params) { { :neverland => { :latitude => latitude, :longitude => longitude, :error_code => error_code } } }
      let(:env) { Rack::MockRequest.env_for('/bananas', :params => params) }

      it 'should return the provided latitude' do
        ParameterExtractor.extract(env).latitude.should == latitude
      end

      it 'should return the provided longitude' do
        ParameterExtractor.extract(env).longitude.should == longitude
      end

      it 'should return the provided error code' do
        ParameterExtractor.extract(env).error_code.should == error_code
      end
    end
  end
end
