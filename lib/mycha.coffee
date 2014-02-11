Mocha = require 'mocha'
child = require 'child_process'
_ = require 'underscore'
TestsFinder = require './tests_finder'


class Mycha

  # The default options to use.
  # These options can be overridden by the user using command-line arguments.
  @default_options =
    stdout: process.stdout
    stderr: process.stderr
    reporter: 'dot'
    testDir: 'test'


  # The default Mocha arguments.
  # These are augmented by user-provided mocha arguments.
  @default_mocha_args = (options) ->
    [
      # Set mocha options
      "--compilers", "coffee:coffee-script"
      "--reporter", options.reporter
      "--colors"

      # Include mycha test helper
      "#{__dirname}/helper.coffee"
    ]


  constructor: (currentDir, user_options={}) ->

    # The options to use by this instance.
    @options = @_calculate_final_options user_options


  # Determines the options to be used by Mycha.
  #
  # * user provided options
  # * default options
  # * test files
  _calculate_final_options: (user_options) ->

    # Merge user and default options.
    result = _(user_options).defaults Mycha.default_options

    # Calculate the Mocha arguments.
    result.mochaArgs ?= []
    result.mochaArgs = result.mochaArgs.concat Mycha.default_mocha_args(result)

    # Include files found in /test
    result.mochaArgs = result.mochaArgs.concat new TestsFinder(result.testDir).files()

    result
  get_mocha_args: ->
    @mocha_configuration.to_args().concat @file_configuration.to_args()


  run: (callback) ->
    childProcess = child.spawn path.resolve(__dirname, '../node_modules/mocha/bin/mocha'),
                               @get_mocha_args()
    childProcess.stdout.pipe @mycha_configuration.options.stdout
    childProcess.stderr.pipe @mycha_configuration.options.stderr
    childProcess.on 'exit', callback if callback



module.exports = Mycha
