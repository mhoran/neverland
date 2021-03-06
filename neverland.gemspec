# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "neverland/version"

Gem::Specification.new do |s|
  s.name        = "neverland"
  s.version     = Neverland::VERSION
  s.authors     = ["Matthew Horan"]
  s.email       = ["matthew.horan@livestream.com"]
  s.homepage    = ""
  s.summary     = %q{Mock location provider for navigator.geolocation}
  s.description = %q{Ever need to test geolocation in your Rails app?  This gem makes it easy.}

  s.rubyforge_project = "neverland"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'nokogiri'

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "tzinfo"
  s.add_development_dependency "capybara"
  s.add_development_dependency "jquery-rails"
end
