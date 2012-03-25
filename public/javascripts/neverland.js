// http://dev.w3.org/geo/api/spec-source.html

navigator.geolocation.getCurrentPosition = function(success, error) {
  Neverland.getCoords(function(position) {
    success(position)
  }, function(positionError) {
    error(positionError)
  })
}

var Neverland = (function() {
  var _latitude = 42.31283,
      _longitude = -71.114287,
      _positionError

  var PositionError = function(code) {
    this.PERMISSION_DENIED = 1
    this.POSITION_UNAVAILABLE = 2
    this.TIMEOUT = 3
    this.code = code
    this.message = null
    Object.freeze(this)
  }

  var Coordinates = function() {
    this.latitude = _latitude,
    this.longitude = _longitude,
    this.altitude = null,
    this.accuracy = 33,
    this.altitudeAccuracy = null,
    this.heading = null,
    this.speed = null
    Object.freeze(this)
  }

  var Position = function() {
    this.coords = new Coordinates()
    this.timestamp = Date.now()
    Object.freeze(this)
  }

  return {
    getCoords: function (success, error) {
      if (_positionError)
        error(_positionError)
      else
        success(new Position())
    },

    setLatitude: function(latitude) {
      _latitude = latitude;
    },

    setLongitude: function(longitude) {
      _longitude = longitude;
    },

    setError: function(code) {
      _positionError = new PositionError(code);
    }
  }
})()
