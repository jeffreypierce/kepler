Maths = require "./maths"

window.AudioContext = window.AudioContext || window.webkitAudioContext
context = new AudioContext()

mainMix = context.createGain()
compressor = context.createDynamicsCompressor()



low = context.createBiquadFilter()
low.type = 'lowshelf'
low.frequency.value = 320.0
low.gain.value = 15.0
low.connect compressor

mid = context.createBiquadFilter()
mid.type = 'peaking'
mid.frequency.value = 1000.0
mid.Q.value = 0.5
mid.gain.value = 0.0
mid.connect low

high = context.createBiquadFilter()
high.type = 'highshelf'
high.frequency.value = 3200.0
high.gain.value = -15.0
high.connect mid

filter = context.createBiquadFilter()
filter.frequency.value = 20000.0
filter.type = 'lowpass'
filter.connect high

mainMix.connect filter
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

    doubler = context.createGain()
    doubler.gain.value = 0.5

    @volume = 0.8 / 6
    @output = context.createGain()
    @output.gain.value = 0

    @osc = context.createOscillator()
    @osc.type = 'sine'

    @osc2 = context.createOscillator()
    @osc2.type = 'sine'

    @osc.connect dry
    @osc.connect reverb

    @osc2.connect doubler
    doubler.connect dry
    doubler.connect reverb

    reverb.connect wet

    wet.connect @output
    dry.connect @output

    @panner = context.createPanner()
    @panner.setPosition 0, 0, 0
    @panner.panningModel = 'equalpower'

    @output.connect @panner
    @panner.connect mainMix

  play: (freq, position) ->
    @update freq, position
    @osc.start context.currentTime
    @osc2.start context.currentTime
    @setVolume @volume

  update: (freq, position) ->
    @setPan position
    @osc.frequency.value = freq
    @osc2.frequency.value = freq * 2

  stop: ->
    @osc.stop context.currentTime
    @osc2.stop context.currentTime

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
