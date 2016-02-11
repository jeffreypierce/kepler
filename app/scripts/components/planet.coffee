React = require "react"
Reflux = require "reflux"
Switch = require "./switch"
Audio = require '../models/audio'
NavbarStore = require "../stores/navbarStore"

Planet = React.createClass
  mixins: [
    Reflux.connect NavbarStore, "navbarState"
    Reflux.listenTo NavbarStore,"onAudioToggle"
  ]

  getInitialState: ->
    {
      sound: null,
      rotation: @props.longitude
      isSelected: false
      muted: false
    }

  rotate: (pos)->
    pos

  onAudioToggle: ->
    if @state.navbarState.audioOn and @state.sound is null
      @setState {sound: new Audio()}
      @state.sound.play @props.freq, @props.longitude, @props.latitude
    else if !@state.navbarState.audioOn
      @state.sound?.stop()
      @setState {sound: null}

  onPlanetClicked: ->
    @setState {isSelected: !@state.isSelected}

  handleMuteChange: (event)->
    console.log event
    event.preventDefault()
    event.stopPropagation()
    @setState {muted: !@state.muted}

  componentDidMount: ->
    @onAudioToggle()

  componentWillReceiveProps: ->
    @state.sound.update @props.freq, @props.longitude  if @state.navbarState.audioOn
    @setState {rotation: @rotate(@props.longitude)}

  render: ->
    orbitClass = "orbit"
    if @state.isSelected
      orbitClass = "orbit info-on"
    orbitRotation =
      WebkitTransform: "rotate( #{@state.rotation}deg)",
      MozTransform: "rotate( #{@state.rotation}deg)"
    bodyRotation =
      WebkitTransform: "rotate( #{-@state.rotation}deg)",
      MozTransform: "rotate( #{-@state.rotation}deg)"
    (
      <div className={@props.planetName + " planet"} >
        <div className={orbitClass} style={orbitRotation} >
          <div className="body" style={bodyRotation} onClick={@onPlanetClicked}>
            <div className="planet__info">
              <h3 className="planet__name">{@props.planetName}</h3>
              <dl>
                <dt>Frequency</dt><dd>{@props.freq}</dd>
                <dt>Approx. Note</dt><dd>{@props.noteName}</dd>
                <dt>Eliptic Longitude</dt><dd>{@props.longitude}</dd>
                <dt>Perihelion</dt><dd>{@props.P}</dd>
                <dt>Eliptic Latitude</dt><dd>{@props.latitude}</dd>
              </dl>

             </div>
            <label className="planet__symbol">{@props.planetLabel}</label>
          </div>
        </div>
      </div>
    )

module.exports = Planet
