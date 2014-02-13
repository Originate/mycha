_ = require 'underscore'


# Parses the Mocha configuration values out of the given command-line arguments,
# augments them with intelligent default values,
# and represents them in a user-friendly way.
class MochaConfiguration

  # Parameters:
  # - run_options: the options given for this run (i.e. on the command line)
  # - default_mocha_options: the default mocha options (defined in mycha.coffee)
  # - files: any specific test files given for this run
  constructor: ({run_options, default_mocha_options, files}) ->

    # The final Mocha options to use.
    @options = @merge_options run_options,
                              default_mocha_options

    # Use 'spec' reporter when running individual test files.
    if files.length > 0 and !run_options.reporter
      @options.reporter = 'spec'


  # Augments the given command-line option with the given default values.
  merge_options: (run_options, default_options) ->
    _.chain(run_options)
     .clone()
     .defaults(default_options)
     .value()


  # Serializes this data into a format so that it can be given to
  # childProcess.spawn.
  to_args: ->
    result = []
    for own key, value of @options
      continue if value is false
      result.push "--#{key}"
      result.push value unless value is true
    result



module.exports = MochaConfiguration
