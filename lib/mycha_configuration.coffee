# Parses the Mycha options out of the given command-line arguments
# augments them with default values,
# and represents them in a user-friendly format.
class MychaConfiguration

  # Parameters:
  # - default_mycha_options: the default Mycha options (defined in mycha.coffee)
  # - argv: the command-line arguments, as provided by Optimist
  constructor: (default_mycha_options, argv) ->

    # The configuration options to use.
    @options = {}
    for own key, value of default_mycha_options
      @options[key] = argv[key] ? default_mycha_options[key]
      delete argv[key]

    # The user options that have not been used here.
    @remaining_options = argv



module.exports = MychaConfiguration
