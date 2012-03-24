// http://dev.w3.org/geo/api/spec-source.html

navigator.geolocation.getCurrentPosition = function(success, error) {
  success({coords: Neverland.getCoords(), timestamp: Date.now()});
}

var Neverland = new function() {
  var _latitude = 42.31283;
  var _longitude = -71.114287;

  return {
    getCoords: function () {
      return {
        latitude: _latitude,
        longitude: _longitude,
        altitude: null,
        accuracy: 33,
        altitudeAccuracy: null,
        heading: null,
        speed: null
      };
    },

    setLatitude: function(latitude) {
      _latitude = latitude;
    },

    setLongitude: function(longitude) {
      _longitude = longitude;
    }
  }
}
