React = require "react"
NavbarActions = require "../actions/navbarActions"

MainMenu = React.createClass

  render: ->
    (
      <div className="grid_4 mainmenu" onClick=NavbarActions.navbarToggle>
        <div className="hamburger">
          <div className="hamburger-bars">&nbsp;</div>
        </div>
        <a className="title">Harmonices Mundi</a>
      </div>
    )

module.exports = MainMenu
