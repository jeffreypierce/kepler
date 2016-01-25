React = require "react"
SolarSystem = require './components/solarSystem'
Navbar = require './components/navbar'
About = require './components/about'

App = React.createClass

  render: ->
    (
      <div className="container">
        <Navbar />
        <SolarSystem />
        <About />
      </div>
    )

React.render <App />, document.getElementById 'app'
