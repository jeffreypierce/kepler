class Maths
  constructor: ->
    @deg2rad = Math.PI / 180
    @rad2deg = 180 / Math.PI
  rev:(angle) ->
    angle - Math.floor(angle / 360) * 360
  rev2:(angle) ->
    a = @rev angle
    if a >= 180 then a - 360 else a
  sind:(angle) ->
    Math.sin angle * @deg2rad
  cosd:(angle) ->
    Math.cos angle * @deg2rad
  tand:(angle) ->
    Math.tan angle * @deg2rad
  asind:(angle) ->
    Math.asin angle * @rad2deg
  acosd:(angle) ->
    Math.acos angle * @rad2deg
  atand:(angle) ->
    Math.atan angle * @rad2deg
  atan2d:(y, x) ->
    Math.atan2(y, x) * @rad2deg
  normalize: (num, precision = 3) ->
    multiplier = Math.pow 10, precision
    Math.round(num * multiplier) / multiplier


module.exports = new Maths()
