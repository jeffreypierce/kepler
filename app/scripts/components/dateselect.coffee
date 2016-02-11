React = require "react"
Reflux = require "reflux"
DateStore = require "../stores/dateStore"
DateActions = require "../actions/dateActions"

DateSelect = React.createClass
  mixins: [Reflux.connect DateStore, "date"]
  getInitialState: ->
    {
      day: ''
      month: ''
      year: ''
      displayState: true
    }

  clearFields: ->
    @setState {
      day: ''
      month: ''
      year: ''
    }

  switchDisplay: ->
    @clearFields()
    @setState {displayState: !@state.displayState}

  handleMonthChange: ->
    @setState {month: event.target.value}

  handleDayChange: ->
    @setState {day: event.target.value}

  handleYearChange: ->
    @setState {year: event.target.value}

  handleKeyDown: ->
    if event.keyCode is 13
      @setDate()

  resetToToday: ->
    DateActions.selectNewDate()
    @switchDisplay()


  setDate: ->
    newDate = "#{@state.year} #{@state.month} #{@state.day} 12:00"
    DateActions.selectNewDate(newDate)
    @switchDisplay()

  render: ->
    dateselectClass = "dateselect"
    if !@state.displayState
      dateselectClass = "dateselect input-on"
    (
      <div className="navbar__center">
        <div className={dateselectClass}>
          <a onClick={@switchDisplay} className="dateselect__display">{@state.date.string}</a>
          <span className="dateselect__inputs">
            <input className="dateselect__input month" maxLength="2" placeholder="MM" value={@state.month} onKeyDown={@handleKeyDown} onChange={@handleMonthChange} type="text" pattern="[0-9]*" inputmode="numeric" />/
            <input className="dateselect__input day"  maxLength="2" placeholder="DD" value={@state.day} onKeyDown={@handleKeyDown} onChange={@handleDayChange} type="text" pattern="[0-9]*" inputmode="numeric"/>/
            <input className="dateselect__input year" maxLength="4" placeholder="YYYY" value={@state.year} onKeyDown={@handleKeyDown} onChange={@handleYearChange} type="text" pattern="[0-9]*" inputmode="numeric" />
            <a onClick={@setDate} className="button go">&#10132;</a>
            <a className="today-reset" onClick={@resetToToday}>Today</a>

          </span>
        </div>
      </div>

    )

module.exports = DateSelect
