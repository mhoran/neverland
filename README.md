[![Build Status](https://secure.travis-ci.org/mhoran/neverland.png)](http://travis-ci.org/mhoran/neverland)

# Neverland

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

## Caveats

The implementation is pretty stupid about when to override your browser's
geolocation implementation (it just inserts a JavaScript tag into the
response).  I'll work on making this smarter.
