React = require "react"
Reflux = require "reflux"
Planet = require "./planet"
planets = require "../models/planets"
DateStore = require "../stores/dateStore"

SolarSystem = React.createClass
  mixins: [
    Reflux.connect(DateStore, "date")
    Reflux.listenTo(DateStore, "onDateChange")
  ]

  getInitialState: ->
    {
      planets: planets
    }

  onDateChange: () ->
    @calculatePositionOnDate()

  calculatePositionOnDate: ->
    @state.planets.map (planet) =>
      planet.positionOnDate @state.date.moment

  componentWillMount: ->
    @calculatePositionOnDate()

  render: ->
    (
      <div>
        {@state.planets.map (planet, i) =>
           <Planet  planetName = {planet.name}
                    planetLabel = {planet.label}
                    key = {i}
                    freq = {planet.freq}
                    position = {planet.eclipticLongitude}
            />
          }
        </div>
      )

module.exports = SolarSystem
