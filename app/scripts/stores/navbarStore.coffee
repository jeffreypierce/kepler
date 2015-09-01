Reflux = require "reflux"
NavbarActions = require "../actions/navbarActions"
DateActions = require "../actions/dateActions"

interval = null
navbarState =
  audioOn: false
  animationOn: false
  navbarClass: 'navbar'

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
      interval = setInterval DateActions.incrementForwards, 50
    else clearInterval interval

    @trigger navbarState

  onNavbarToggle: ->
    navbarState.navbarClass = if navbarState.navbarClass is 'navbar' then 'navbar open' else 'navbar'
    @trigger navbarState

module.exports = NavbarStore
