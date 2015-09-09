React = require "react"
Reflux = require "reflux"
Switch = require "./switch"
NavbarActions = require "../actions/navbarActions"
NavbarStore = require "../stores/navbarStore"

Controls = React.createClass
  mixins: [Reflux.connect NavbarStore, "navbarState"]

  handleAudioChange: ->
    NavbarActions.audioToggle()

  handleAnimationChange: ->
    NavbarActions.animationToggle()

  render: ->
    (
      <div className="grid_4 controls">
        <Switch id="audio"
                label="Audio"
                className="audio-switch"
                checkedState={@state.navbarState.audioOn}
                callback={@handleAudioChange} />

        <Switch id="animation"
                label="Animation"
                className="animation-switch"
                checkedState={@state.navbarState.animationOn}
                callback={@handleAnimationChange} />
      </div>

    )

module.exports = Controls
