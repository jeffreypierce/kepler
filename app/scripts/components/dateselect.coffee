React = require "react"
Reflux = require "reflux"
DateStore = require "../stores/dateStore"

DateSelect = React.createClass
  mixins: [Reflux.connect DateStore, "date"]

  render: ->
    (
      <div className="grid_4 dateselect">
        <a>{@state.date.format("MMMM Do • YYYY")}</a>
      </div>

    )

module.exports = DateSelect
