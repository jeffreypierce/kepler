Reflux = require "reflux"
moment = require "moment"
DateActions = require "../actions/dateActions"

date = moment()

DateStore = Reflux.createStore
  listenables: DateActions
  getInitialState: ->
    date

  incrementForwards: ->
    @updateDate date.add(1, 'hour')

  incrementBackwards: ->
    @updateDate date.subtract(1, 'hour')

  updateDate: (newDate)->
    date = newDate
    @trigger date

module.exports = DateStore
