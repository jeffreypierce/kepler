React = require "react"

Switch = React.createClass

  render: ->
    (
      <span className={@props.className}>
        <input  className="switch"
                id={@props.id}
                type="checkbox"
                checked={@props.checkedState}
                onChange={@props.callback} />
        <label  className="switch__label"
                htmlFor={@props.id}>
                <span className="switch__title">{@props.label}</span>
        </label>
      </span>
    )

module.exports = Switch
