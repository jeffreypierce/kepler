React = require "react"
Reflux = require "reflux"
Audio = require '../models/audio'
NavbarStore = require "../stores/navbarStore"

Planet = React.createClass
  mixins: [
    Reflux.connect(NavbarStore, "navbarState")
    Reflux.listenTo(NavbarStore,"onAudioToggle")
  ]

  getInitialState: ->
    {
      sound: null,
      rotation: @rotate(@props.position)
    }

  rotate: (pos)->
    (360 + pos) % 360

  onAudioToggle: () ->
    if @state.navbarState.audioOn and @state.sound is null
      @setState {sound: new Audio()}
      @state.sound.play @props.freq, @props.position
    else if !@state.navbarState.audioOn
      @state.sound?.stop()
      @setState {sound: null}

  componentDidMount: ->
    @onAudioToggle()

  componentWillReceiveProps: ->
    @state.sound.update @props.freq, @props.position  if @state.navbarState.audioOn
    @setState {rotation: @rotate(@props.position)}

  render: ->
    orbitRotation =
      WebkitTransform: "rotate( #{@state.rotation}deg)",
      MozTransform: "rotate( #{@state.rotation}deg)"
    bodyRotation =
      WebkitTransform: "rotate( #{-@state.rotation}deg)",
      MozTransform: "rotate( #{-@state.rotation}deg)"
    (
      <div className={@props.planetName + " planet"} >
        <div className="orbit" style={orbitRotation}>
          <div className="body" style={bodyRotation}>
            <label className="planet-symbol">{@props.planetLabel}</label>
          </div>
        </div>
      </div>
    )

module.exports = Planet
