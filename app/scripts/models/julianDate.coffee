class JulianDate
  constructor: ()->
  toJulian: (date)->
    date.valueOf()/86400000 + 2440587.5

  toDate: (@julianDate) ->
    X = parseFloat(@julianDate) + 0.5
    Z = Math.floor(X)
    #Get day without time
    F = X - Z
    #Get time
    Y = Math.floor((Z - 1867216.25) / 36524.25)
    A = Z + 1 + Y - Math.floor(Y / 4)
    B = A + 1524
    C = Math.floor((B - 122.1) / 365.25)
    D = Math.floor(365.25 * C)
    G = Math.floor((B - D) / 30.6001)
    #must get number less than or equal to 12)
    month = if G < 13.5 then G - 1 else G - 13
    #if Month is January or February, or the rest of year
    year = if month < 2.5 then C - 4715 else C - 4716
    month -= 1
    #Handle JavaScript month format
    UT = B - D - Math.floor(30.6001 * G) + F
    day = Math.floor(UT)
    #Determine time
    UT -= Math.floor(UT)
    UT *= 24
    hour = Math.floor(UT)
    UT -= Math.floor(UT)
    UT *= 60
    minute = Math.floor(UT)
    UT -= Math.floor(UT)
    UT *= 60
    second = Math.round(UT)
    new Date(Date.UTC(year, month, day, hour, minute, second))

module.exports = new JulianDate()
