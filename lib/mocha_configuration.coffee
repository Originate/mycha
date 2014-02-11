_ = require 'underscore'


# Represents the configuration options for Mocha.
class MochaConfiguration

  constructor: (default_mocha_options, user_options = {}) ->

    # The final Mocha options to use.
    @options = _(user_options).defaults default_mocha_options



module.exports = MochaConfiguration
