Reflux = require "reflux"
NavbarActions = require "../actions/navbarActions"
DateActions = require "../actions/dateActions"

interval = null
navbarState =
  audioOn: false
  animationOn: false
  playOn: false
  open: false
  volume: 40
  controlsVisable: false

NavbarStore = Reflux.createStore
  listenables: NavbarActions
  getInitialState: ->
    navbarState

  onAudioToggle: ->
    navbarState.audioOn = !navbarState.audioOn
    @checkState()
    @trigger navbarState

  onPlayToggle: ->
    navbarState.playOn = !navbarState.playOn
    if navbarState.playOn
      navbarState.audioOn = true
      navbarState.animationOn = true
    else
      navbarState.audioOn = false
      navbarState.animationOn = false

    @animate()
    @trigger navbarState

  animate: ->
    if navbarState.animationOn
      interval = setInterval DateActions.incrementDate, 50
    else clearInterval interval

  onAnimationToggle: ->
    navbarState.animationOn = !navbarState.animationOn
    @animate()
    @checkState()
    @trigger navbarState

  checkState: ->
    if navbarState.animationOn and navbarState.audioOn
      navbarState.playOn = true
    else
      navbarState.playOn = false

  onShowControlsToggle: ->
    console.log "cricked"
    navbarState.controlsVisable = !navbarState.controlsVisable
    @trigger navbarState

  onNavbarToggle: ->
    navbarState.open = !navbarState.open
    @trigger navbarState

  updateVolume: (vol)->
    navbarState.volume = vol
    window.mainMix.gain.value = vol/100
    @trigger navbarState

module.exports = NavbarStore
