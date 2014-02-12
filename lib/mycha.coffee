child = require 'child_process'
path = require 'path'
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
  constructor: (@project_directory) ->

    # TODO: read the config file here


  get_mocha_args: ->
    @mocha_configuration.to_args().concat @file_configuration.to_args()


  run: (run_options, files, done) ->

    # The options to configure this Mycha instance.
    @mycha_configuration = new MychaConfiguration
      run_options: run_options
      default_mycha_options: Mycha.default_mycha_options
      files: files

    # The options to provide to Mocha.
    @mocha_configuration = new MochaConfiguration
      run_options: run_options
      default_mocha_options: Mycha.default_mocha_options,
      files: files

    # The JS/CS files to provide to Mocha.
    @file_configuration = new FileConfiguration
      test_dir: "#{process.cwd()}/#{@mycha_configuration.options.testDir}"
      default_files: Mycha.default_files
      files: files

    @call_mocha @get_mocha_args(),
                done


  #
  watch: (run_options, files) ->


  call_mocha: (mocha_args, done) ->
    childProcess = child.spawn path.resolve(__dirname, '../node_modules/mocha/bin/mocha'),
                               mocha_args
    childProcess.stdout.pipe @mycha_configuration.options.stdout
    childProcess.stderr.pipe @mycha_configuration.options.stderr
    childProcess.on 'exit', done if done



module.exports = Mycha
