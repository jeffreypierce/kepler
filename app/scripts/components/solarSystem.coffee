React = require "react"
Reflux = require "reflux"
Planet = require "./planet"
planets = require "../models/planets"
DateStore = require "../stores/dateStore"

SolarSystem = React.createClass
  mixins: [
    Reflux.connect DateStore, "date"
    Reflux.listenTo DateStore, "onDateChange"
  ]

  getInitialState: ->
    {
      planets: planets
    }

  onDateChange: ->
    @calculatePositionOnDate()

  calculatePositionOnDate: ->
    @state.planets.map (planet) =>
      planet.positionOnDate @state.date.moment
      planet.noteFromFreq()

  componentWillMount: ->
    @calculatePositionOnDate()

  render: ->
    (
      <div>
        {@state.planets.map (planet, i) =>
           <Planet  planetName = {planet.name}
                    planetLabel = {planet.label}
                    key = {i}
                    freq = {planet.frequency}
                    longitude = {planet.longitude}
                    latitude = {planet.latitude}
                    noteName = {planet.noteName}
                    P = {planet.P}
            />
          }
        </div>
      )

module.exports = SolarSystem
