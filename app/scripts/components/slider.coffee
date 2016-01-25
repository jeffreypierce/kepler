React = require "react"

Slider = React.createClass

  render: ->
    (
      <span className={@props.className + " slider"}>
        <label  className="slider__label"
                htmlFor={@props.id}>
                {@props.label}
        </label>
        <input  className="slider__input"
                id={@props.id}
                type="range"
                onChange={@props.callback}
                min={@props.min}
                max={@props.max}
                value={@props.value}
                step={@props.step}
                />
      </span>

    )

module.exports = Slider
