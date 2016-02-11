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

    mainControlsClass = "controls__main"
    smallControlsClass = "controls__small"
    if @state.navbarState.controlsVisable
      mainControlsClass = "controls__main show"
      smallControlsClass = "controls__small show"




    (
      <div className="navbar__right">
        <div className="controls">
          <div className={smallControlsClass}>
            <Switch id="play"
                    label="Play"
                    className="play-switch"
                    checkedState={@state.navbarState.playOn}
                    callback={NavbarActions.playToggle} />

            <a onClick={NavbarActions.showControlsToggle} className="more"></a>
          </div>

          <div className={mainControlsClass}>
            <Switch id="audio"
                    label="Audio"
                    className="audio-switch"
                    checkedState={@state.navbarState.audioOn}
                    callback={NavbarActions.audioToggle} />

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
                    callback={NavbarActions.animationToggle} />

            <Slider id="speed"
                    label="Speed"
                    className={speedSliderClass}
                    callback={@adjustSpeed}
                    min="-48"
                    max="48"
                    step="1"
                    value={@state.date.speed} />
          </div>
        </div>
      </div>

    )

module.exports = Controls
