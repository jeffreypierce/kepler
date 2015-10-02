Reflux = require "reflux"
moment = require "moment"
DateActions = require "../actions/dateActions"

date =
  moment: moment()
  string: null

DateStore = Reflux.createStore
  listenables: DateActions
  getInitialState: ->
    @formatDate()
    date

  incrementForwards: ->
    @updateDate date.moment.add(1, 'day')

  incrementBackwards: ->
    @updateDate date.moment.subtract(1, 'hour')

  formatDate: ->
    date.string = date.moment.format("MMMM Do • YYYY • ha")

  updateDate: ->
    @formatDate()
    @trigger date

module.exports = DateStore
