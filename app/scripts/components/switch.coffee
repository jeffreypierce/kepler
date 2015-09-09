React = require "react"

Switch = React.createClass

  render: ->
    (
      <span className={@props.className + " switch"}>
        <label  className="switch__label"
                htmlFor={@props.id}>
                {@props.label}
        </label>
        <input  className="switch__input"
                id={@props.id}
                type="checkbox"
                checked={@props.checkedState}
                onChange={@props.callback} />
      </span>
    )

module.exports = Switch
