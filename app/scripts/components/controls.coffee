React = require "react"
Reflux = require "reflux"
Switch = require "./switch"
Slider = require "./slider"
NavbarActions = require "../actions/navbarActions"
NavbarStore = require "../stores/navbarStore"
DateStore = require "../stores/dateStore"
DateActions = require "../actions/dateActions"

Controls = React.createClass
  mixins: [
    Reflux.connect NavbarStore, "navbarState"
    Reflux.connect DateStore, "date"
  ]

  handleAudioChange: ->
    NavbarActions.audioToggle()

  handleAnimationChange: ->
    NavbarActions.animationToggle()

  adjustSpeed: ->
    if @state.navbarState.animationOn
      DateActions.updateSpeed event.target.value

  adjustVolume: ->
    if @state.navbarState.audioOn
      NavbarActions.updateVolume event.target.value

  render: ->
    speedSliderClass = "speed-slider"
    if !@state.navbarState.animationOn
      speedSliderClass = "speed-slider disabled"

    volSliderClass = "volume-slider"
    if !@state.navbarState.audioOn
      volSliderClass = "volume-slider disabled"
    (
      <div className="grid_4 controls">
        <Switch id="audio"
                label="Audio"
                className="audio-switch"
                checkedState={@state.navbarState.audioOn}
                callback={@handleAudioChange} />

        <Slider id="volume"
                label="Volume"
                className={volSliderClass}
                callback={@adjustVolume}
                min="0"
                max="90"
                step="5"
                value={@state.navbarState.volume} />

        <Switch id="animation"
                label="Animation"
                className="animation-switch"
                checkedState={@state.navbarState.animationOn}
                callback={@handleAnimationChange} />

        <Slider id="speed"
                label="Speed"
                className={speedSliderClass}
                callback={@adjustSpeed}
                min="-48"
                max="48"
                step="1"
                value={@state.date.speed} />


      </div>

    )

module.exports = Controls
