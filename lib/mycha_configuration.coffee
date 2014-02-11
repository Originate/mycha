# Represents configuration options for Mycha.
#
# Determines the final Mycha configuration from the given
# default and user-provided options,
# and provides the user options that have not been used here.
class MychaConfiguration

  constructor: (default_mycha_options, user_options={}) ->

    # The configuration options to use.
    @options = {}
    for own key, value of default_mycha_options
      @options[key] = user_options[key] ? default_mycha_options[key]
      delete user_options[key]

    # The user options that have not been used here.
    @remaining_options = user_options



module.exports = MychaConfiguration
