Maths = require "./maths"

window.AudioContext = window.AudioContext || window.webkitAudioContext
context = new AudioContext()
mainMix = context.createGain()
compressor = context.createDynamicsCompressor()
mainMix.connect compressor
compressor.connect context.destination

generateImpulse = (length = 2, decay = 3) ->
  rate = context.sampleRate
  bufferSize = rate * length
  impulse = context.createBuffer 1, bufferSize, rate
  channel = impulse.getChannelData 0
  i = 0
  while i < bufferSize
    channel[i] = (2 * Math.random() - 1) * Math.pow(1 - i / bufferSize, decay)
    i++
  impulse

class Audio
  constructor: ()->
    reverb = context.createConvolver()
    reverbBuffer = generateImpulse()
    reverb.buffer = reverbBuffer

    wet = context.createGain()
    dry = context.createGain()
    wet.gain.value = 0.8 / 2
    dry.gain.value = 0.3 / 2

    @volume = 0.8 / 6
    @output = context.createGain()
    @output.gain.value = 0

    @osc = context.createOscillator()
    @osc.type = 'sine'

    @panner = context.createPanner()
    @panner.setPosition 0, 0, 0
    @panner.panningModel = 'equalpower'

    @osc.connect dry
    @osc.connect reverb
    reverb.connect wet

    wet.connect @output
    dry.connect @output

    @output.connect @panner
    @panner.connect mainMix

    mainMix

  play: (freq, position) ->
    @update freq, position
    @osc.start context.currentTime
    @setVolume @volume

  update: (freq, position) ->
    @setPan position
    @osc.frequency.value = freq

  stop: ->
    @osc.stop context.currentTime

  setPan: (position) ->
    xDeg = position
    zDeg = (xDeg % 180) + 90
    zDeg = 180 - zDeg if zDeg > 90
    x = Maths.sind xDeg
    y = 0
    z = Maths.sind zDeg

    @panner.setPosition x, y, z

  setVolume: (vol, speed = 3) ->
    @output.gain.setValueAtTime @output.gain.value, context.currentTime
    @output.gain.linearRampToValueAtTime vol, context.currentTime + speed

module.exports = Audio
