# Neverland

[![Build Status](https://secure.travis-ci.org/mhoran/neverland.png)](http://travis-ci.org/mhoran/neverland)

Neverland takes the pain out of testing HTML5 geolocation within your Rails
app.  For more on HTML5 geolocation, check out [the
spec](http://dev.w3.org/geo/api/spec-source.html).

## Getting Started

To install, add the following to your Gemfile:

```ruby
gem 'neverland'
```

In your test environment initializer, add the Neverland middleware:

```ruby
Dummy::Application.configure do
  # ...

  config.middleware.use Neverland::Middleware
end
```

By default, Neverland will mock the result of
navigator.geolocation.getCurrentLocation to latitude 42.31283, longitude
-71.114287.  This can be overridden by sending the parameters
`neverland[:latitude]` and `neverland[:longitude]`.  Error states can also be
triggered by setting `neverland[:error_code]`.

## Caveats

The implementation is pretty stupid about when to override your browser's
geolocation implementation (it just inserts a JavaScript tag into the
response).  I'll work on making this smarter.
