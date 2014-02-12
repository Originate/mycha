_ = require 'underscore'


# Parses the Mycha options out of the given command-line arguments,
# augments them with default values,
# and represents them in a user-friendly format.
class MychaConfiguration

  # Parameters:
  # - run_options: the options given for this run (i.e. on the command line)
  # - default_mycha_options: the default Mycha options (defined in mycha.coffee)
  constructor: ({run_options, default_mycha_options}) ->

    # The configuration options to use.
    @options = @merge_options run_options,
                              default_mycha_options

    # The user options that have not been used here.
    @remaining_options = @remove_used_options @options,
                                              run_options


  # Merges the given user options with the given default options.
  merge_options: (run_options, default_options) ->
    result = {}
    for own key, value of default_options
      result[key] = run_options[key] ? default_options[key]
    result


  # Returns the given hash with the keys from the given used options removed.
  remove_used_options: (used_options, hash) ->
    result = _(hash).clone()
    delete result[key] for own key, value of used_options
    result



module.exports = MychaConfiguration
