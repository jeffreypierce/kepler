Reflux = require "reflux"
NavbarActions = require "../actions/navbarActions"
DateActions = require "../actions/dateActions"

interval = null
navbarState =
  audioOn: false
  animationOn: false
  openClass: ''
  volume: 40

NavbarStore = Reflux.createStore
  listenables: NavbarActions
  getInitialState: ->
    navbarState

  onAudioToggle: ->
    navbarState.audioOn = !navbarState.audioOn
    @trigger navbarState

  onAnimationToggle: ->
    navbarState.animationOn = !navbarState.animationOn
    if navbarState.animationOn
      interval = setInterval DateActions.incrementDate, 50
    else clearInterval interval

    @trigger navbarState

  onNavbarToggle: ->
    navbarState.openClass = if navbarState.openClass is '' then 'open' else ''
    @trigger navbarState

  updateVolume: (vol)->
    navbarState.volume = vol
    window.mainMix.gain.value = vol/100
    @trigger navbarState

module.exports = NavbarStore
