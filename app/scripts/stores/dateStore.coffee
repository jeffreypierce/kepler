Reflux = require "reflux"
moment = require "moment"
DateActions = require "../actions/dateActions"

date =
  moment: moment()
  string: null
  speed: 2

DateStore = Reflux.createStore
  listenables: DateActions
  getInitialState: ->
    @formatDate()
    date

  incrementDate: ->
    @updateDate date.moment.add(date.speed, 'hour')

  formatDate: ->
    date.string = date.moment.format("MMMM Do • YYYY")

  updateSpeed: (speed)->
    date.speed = speed

  updateDate: ->
    @formatDate()
    @trigger date

  selectNewDate: (dateString)->
    if dateString?
      date.moment = moment(dateString, "YYYY MM DD HH:mm")
    else
      date.moment = moment()

    @formatDate()
    # FIX ME
    # this is a sad, terrible hack - but the only way I could get it to work
    @trigger date
    @trigger date
    @trigger date

module.exports = DateStore
