_ = require 'underscore'


# Parses the Mocha configuration values out of the given command-line arguments,
# augments them with intelligent default values,
# and represents them in a user-friendly way.
class MochaConfiguration

  # Parameters:
  # - default_mocha_options: the default mocha options (defined in mycha.coffee)
  # - argv: the command-line arguments, as provided by Optimist
  constructor: (default_mocha_options, argv) ->

    # The final Mocha options to use.
    @options = @remove_optimist_elements @merge_options(argv,
                                                        default_mocha_options)


  # Removes the elements of argv that Optimist adds.
  remove_optimist_elements: (options) ->
    delete options._
    delete options['$0']
    options


  # Augments the given command-line option with the given default values.
  merge_options: (argv, default_options) ->
    _.chain(argv)
     .clone()
     .defaults(default_options)
     .value()


  # Serializes this data into a format so that it can be given to
  # childProcess.spawn.
  to_args: ->
    result = []
    for own key, value of @options
      result.push "--#{key}"
      result.push value unless value is true
    result


module.exports = MochaConfiguration
