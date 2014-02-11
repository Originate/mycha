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
    @options = _.chain(argv)
                .defaults(default_mocha_options)
                .clone()
                .value()
    delete @options._
    delete @options['$0']



module.exports = MochaConfiguration
