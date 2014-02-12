_ = require 'underscore'


# Makes command-line arguments provided by Optimist conveniently available.
class OptimistParser

  # Parameters:
  # - argv: the argv value from Optimist
  constructor: (@argv) ->


  # Returns the command in the given argv structure.
  command: ->
    @argv._[0] ? 'run'


  # Returns the files given on the command line.
  files: ->
    @argv._[1..]


  # Returns the options given on the command line.
  options: ->
    @remove_optimist_elements @argv


  # Removes the Optimist-internal elements of the given argv.
  remove_optimist_elements: (argv) ->
    result = _(argv).clone()
    delete result._
    delete result['$0']
    result



module.exports = OptimistParser
