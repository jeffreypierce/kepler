React = require "react"
NavbarActions = require "../actions/navbarActions"

MainMenu = React.createClass

  render: ->
    (
      <div className="grid_4" >
        <a className="mainmenu" onClick={NavbarActions.navbarToggle}>
          <div className="hamburger">
            <div className="hamburger__bars">&nbsp;</div>
          </div>
          <span className="title">Harmonices Mundi</span>
        </a>
      </div>
    )

module.exports = MainMenu
