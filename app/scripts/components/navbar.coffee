React = require "react"
Reflux = require "reflux"
MainMenu = require "./mainmenu"
DateSelect = require "./dateselect"
Controls = require "./controls"
NavBarStore = require "../stores/navbarStore"

Navbar = React.createClass
  mixins: [Reflux.connect NavBarStore,"navbarState"]

  render: ->
    (
      <nav className={"navbar "+@state.navbarState.openClass}>
        <MainMenu />
        <DateSelect />
        <Controls />
      </nav>
    )

module.exports = Navbar
