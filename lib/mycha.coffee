child = require 'child_process'
jath = require 'path'
_ = require 'underscore'
TestsFinder = require './tests_finder'
MychaConfiguration = require './mycha_configuration'
MochaConfiguration = require './mocha_configuration'
FileConfiguration = require './file_configuration'


# The main class. Performs the Mycha functionality.
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


  # Any files that Mocha should always load, in addition to the test files.
  @default_files = [
    # The Mycha test helper
    "#{__dirname}/helper.coffee"
  ]


  # parameters:
  # - argv: argument values provided by Optimist.
  constructor: (argv) ->

    # The options to configure this Mycha instance.
    @mycha_configuration = new MychaConfiguration Mycha.default_mycha_options,
                                                  argv

    # The options to provide to Mocha.
    @mocha_configuration = new MochaConfiguration Mycha.default_mocha_options,
                                                  argv

    # The JS/CS files to provide to Mocha.
    @file_configuration = new FileConfiguration
      test_dir: @mycha_configuration.options.testDir
      default_files: Mycha.default_files
      argv: argv


  get_mocha_args: ->
    @mocha_configuration.to_args().concat @file_configuration.to_args()


  run: (callback) ->
    childProcess = child.spawn path.resolve(__dirname, '../node_modules/mocha/bin/mocha'),
                               @get_mocha_args()
    childProcess.stdout.pipe @mycha_configuration.options.stdout
    childProcess.stderr.pipe @mycha_configuration.options.stderr
    childProcess.on 'exit', callback if callback



module.exports = Mycha
