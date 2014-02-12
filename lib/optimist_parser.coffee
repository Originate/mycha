_ = require 'underscore'


# Makes command-line arguments provided by Optimist conveniently available.
class OptimistParser


  # param:
  # - argv: the argv value from Optimist
  constructor: (@argv) ->


  # Returns the command in the given argv structure.
  command: ->
    @argv._[0] ? 'run'


  # Returns the files given on the command line.
  files: ->
    @argv._[1..]


  options: ->
    @remove_optimist_elements @argv


  # Removes the elements of argv that Optimist adds.
  remove_optimist_elements: (argv) ->
    result = _(argv).clone()
    delete result._
    delete result['$0']
    result



module.exports = OptimistParser
