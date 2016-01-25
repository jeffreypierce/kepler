Maths = require "./maths"

planetData = [
  {
    name: 'mercury'
    label: 'f'
    L: [252.250906, 149474.0722491,    0.00030397,    0.000000018]
    a: [  0.387098310,   0.0,          0.0,           0.0]
    e: [  0.20563175,    0.000020406, -0.0000000284, -0.00000000017]
    i: [  7.004986,      0.0018215,   -0.00001809,    0.000000053]
    N: [ 48.330893,      1.1861890,    0.00017587,    0.000000211]
    P: [ 77.456119,      1.5564775,    0.00029589,    0.000000056]
    pitchRange: [1760, 4171.84]
  }
  {
    name: 'venus'
    label: 'g'
    L: [181.979801,  58519.2130302,    0.00031060,    0.000000015]
    a: [  0.723329820,   0.0,          0.0,           0.0]
    e: [  0.00677188,   -0.000047766,  0.0000000975,  0.00000000044]
    i: [  3.394662,      0.0010037,   -0.00000088,   -0.000000007]
    N: [ 76.679920,      0.9011190,    0.00040665,   -0.000000080]
    P: [131.563707,      1.4022188,   -0.00107337,   -0.000005315]
    pitchRange: [659.998, 695.305]
  }
  {
    name: 'earth'
    label: 'L'
    L: [100.466449,  36000.7698231,    0.00030368,    0.000000021]
    a: [  1.000001018,   0.0,          0.0,           0.0]
    e: [  0.01670862,   -0.000042037, -0.0000001236,  0.00000000004]
    i: [  0.0,           0.0,          0.0,           0.0]
    N: [  0.0,           0.0,          0.0,           0.0]
    P: [102.937348,      1.7195269,    0.00045962,    0.000000499]
    pitchRange: [391.109, 417.655]
  }
  {
    name: 'mars'
    label: 'h'
    L: [355.433275,  19141.6964746,    0.00031097,    0.000000015]
    a: [  1.523679342,   0.0,          0.0,           0.0]
    e: [  0.09340062,    0.000090483, -0.0000000806, -0.00000000035]
    i: [  1.849726,     -0.0006010,    0.00001276,   -0.000000006]
    N: [ 49.558093,      0.7720923,    0.00001605,    0.000002325]
    P: [336.060234,      1.8410331,    0.00013515,    0.000000318]
    pitchRange: [185.624, 260.74]
  }
  {
    name: 'jupiter'
    label: 'j'
    L: [ 34.351484,   3036.3027889,    0.00022374,    0.000000025]
    a: [  5.202603191,   0.0000001913, 0.0,           0.0]
    e: [  0.04849485,    0.000163244, -0.0000004719, -0.00000000197]
    i: [  1.303270,     -0.0054966,    0.00000465,   -0.000000004]
    N: [100.464441,      1.0209550,    0.00040117,    0.000000569]
    P: [ 14.331309,      1.6126668,    0.00103127,   -0.000004569]
    pitchRange: [61.875, 73.333]
  }
  {
    name: 'saturn'
    label: 'S'
    L: [ 50.077471,   1223.5110141,    0.00051952,   -0.000000003]
    a: [  9.554909596,  -0.0000021389, 0.0,           0.0]
    e: [  0.05550862,   -0.000346818, -0.0000006456,  0.00000000338]
    i: [  2.488878,     -0.0037363,   -0.00001516,    0.000000089]
    N: [113.665524,      0.8770979,   -0.00012067,   -0.000002380]
    P: [ 93.056787,      1.9637694,    0.00083757,    0.000004899]
    pitchRange: [24.444, 30.937]
  }
]

class Planet
  constructor: (planetData) ->
    @name = planetData.name
    @label = planetData.label
    @p = planetData
  toJulian: (date) ->
    date.valueOf()/86400000 + 2440587.5
  positionOnDate: (date) ->
    T = (@toJulian(date) - 2451545) / 36525
    T2 = T * T
    T3 = T2 * T
    # longitude of ascending node
    N = Maths.rev @p.N[0] + @p.N[1] * T + @p.N[2] * T2 + @p.N[3] * T3
    # inclination
    i = @p.i[0] + @p.i[1] * T + @p.i[2] * T2 + @p.i[3] * T3
    # Mean longitude
    L = Maths.rev @p.L[0] + @p.L[1] * T + @p.L[2] * T2 + @p.L[3] * T3
    # semimajor axis
    a = @p.a[0] + @p.a[1] * T + @p.a[2] * T2 + @p.a[3] * T3
    # eccentricity
    e = @p.e[0] + @p.e[1] * T + @p.e[2] * T2 + @p.e[3] * T3
    # longitude of perihelion
    P = Maths.rev @p.P[0] + @p.P[1] * T + @p.P[2] * T2 + @p.P[3] * T3
    @P = Maths.normalize P
    M = Maths.rev L - P
    w = Maths.rev L - N - M
    # Eccentric anomaly
    E0 = M + Maths.rad2deg * e * Maths.sind(M) * (1 + e * Maths.cosd(M))
    E = E0 - (E0 - (Maths.rad2deg * e * Maths.sind E0 ) - M) / (1 - (e * Maths.cosd E0 ))
    while Math.abs(E0 - E) > 0.0005
      E0 = E
      E = E0 - (E0 - (Maths.rad2deg * e * Maths.sind E0 ) - M) / (1 - (e * Maths.cosd E0 ))

    x = a * (Maths.cosd(E) - e)
    y = a * Math.sqrt(1 - (e * e)) * Maths.sind E
    # distance
    r = Math.sqrt x * x + y * y
    # true anomaly
    v = Maths.rev Maths.atan2d(y, x)

    # Heliocentric Ecliptic Rectangular Coordinates
    @coords =
      x: r * (Maths.cosd(N) * Maths.cosd(v + w) - Maths.sind(N) * Maths.sind(v + w) * Maths.cosd(i))
      y: r * (Maths.sind(N) * Maths.cosd(v + w) + Maths.cosd(N) * Maths.sind(v + w) * Maths.cosd(i))
      z: r * Maths.sind(v + w) * Maths.sind(i)
    #eliptics degrees
    @elipticLongitude = Maths.atan2d @coords.y, @coords.x
    @elipticLatitude = Maths.atan2d(
      @coords.z,
      Math.sqrt(@coords.x * @coords.x + @coords.y * @coords.y + @coords.z * @coords.z))

    @longitude = Maths.normalize @elipticLongitude
    @latitude = Maths.normalize @elipticLatitude

    freq =
      (@p.pitchRange[1] + @p.pitchRange[0])/2 - (@p.pitchRange[1]
      - @p.pitchRange[0])/2 * Maths.cosd(@elipticLongitude + P)

    @frequency = Maths.normalize freq

  noteFromFreq: ->

    referenceFrequency = =>
      # root frequency of C in equal temperament
      16.351597831287414 * Math.pow 2, @octave

    getNoteLetterFromFrequency = =>
      baseFreq = Math.log @frequency / referenceFrequency()

      # equal temperament naming
      noteNumber = Math.round baseFreq / Math.log Math.pow(2, 1 / 12)

      @octave += 1 if noteNumber is 12
      noteArray = ['C','C#','D','D#','E','F','F#','G','G#','A','A#','B']

      noteArray[noteNumber % 12]

    rootFrequency = 16.351597831287414
    @octave = Math.floor Math.log(@frequency / rootFrequency) / Math.log 2
    letter = getNoteLetterFromFrequency()
    @noteName = letter + @octave.toString()


planets = []

planetData.map (planet)->
  planets.push new Planet(planet)

module.exports = planets
