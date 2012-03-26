require 'spec_helper'

module Neverland
  describe ScriptInjector do
    describe '.inject' do
      context 'with an ActionDispatch::Response' do
        let(:parameters) { Parameters.new }
        let(:response) { ActionDispatch::Response.new(200, {}, ['<html><head></head></html>']) }

        it 'should insert the mock JavaScript into the head' do
          injected_response = ScriptInjector.inject(response, parameters)
          Nokogiri::HTML(injected_response.body).css('head script[src="/javascripts/neverland.js"]').should_not be_empty
        end
      end

      context 'with a Rack::Response' do
        let(:parameters) { Parameters.new }
        let(:response) { Rack::Response.new(['<html><head></head></html>'], 200, {}) }

        it 'should not insert the mock JavaScript into the head' do
          injected_response = ScriptInjector.inject(response, parameters)
          Nokogiri::HTML(injected_response.body.first).css('head script[src="/javascripts/neverland.js"]').should be_empty
        end
      end
    end
  end
end
