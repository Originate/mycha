Mocha = require 'mocha'
child = require 'child_process'
_ = require 'underscore'
TestsFinder = require './tests_finder'


class Mycha

  # Default configuration options for Mycha.
  @default_mycha_options =
    stdout: process.stdout
    stderr: process.stderr
    testDir: 'test'


  # Default configuration options for Mocha.
  @default_mocha_options =
    compilers: "coffee:coffee-script"
    reporter: 'dot'
    colors: yes


  constructor: (currentDir, user_options={}) ->
  # Any files that Mocha should always load, in addition to the test files.
  @default_files = [
    # The Mycha test helper
    "#{__dirname}/helper.coffee"
  ]

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
