React = require "react"
SolarSystem = require './components/solarSystem'
Navbar = require './components/navbar'

App = React.createClass

  render: ->
    (
      <div className="container">
        <Navbar />
        <SolarSystem />
      </div>
    )

React.render <App />, document.getElementById 'app'
