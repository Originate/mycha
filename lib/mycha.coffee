child = require 'child_process'
path = require 'path'
_ = require 'underscore'
TestsFinder = require './helpers/tests_finder'
MychaConfiguration = require './configuration/mycha_configuration'
MochaConfiguration = require './configuration/mocha_configuration'
FileConfiguration = require './configuration/file_configuration'


# The main class. Performs the Mycha functionality.
class Mycha

  # Default configuration options for Mycha.
  @default_mycha_options =
    stdout: process.stdout
    stderr: process.stderr
    testDir: 'test'


  # Default configuration options for Mocha.
  @default_mocha_options =
    compilers: 'coffee:coffee-script/register'
    reporter: 'dot'
    colors: yes


  # Any files that Mocha should always load, in addition to the test files.
  @default_files = [
    # The Mycha test helper
    path.join __dirname, '/test_helper.coffee'
  ]


  # Parameters:
  # - project_directory: the working directory
  constructor: (@project_directory) ->
    # TODO: read the config file here


  # Returns the arguments to provide to Mocha to run the current test suite.
  get_mocha_args: ->
    @mocha_configuration.to_args().concat @file_configuration.to_args()


  # Runs the current test suite according to the given options
  # and user-specified test files.
  run: ({run_options, run_files, done}) ->

    # The options to configure this Mycha instance.
    @mycha_configuration = new MychaConfiguration
      run_options: run_options
      default_mycha_options: Mycha.default_mycha_options

    # The options to provide to Mocha.
    @mocha_configuration = new MochaConfiguration
      run_options: run_options
      default_mocha_options: Mycha.default_mocha_options
      files: run_files

    # The JS/CS files to provide to Mocha.
    @file_configuration = new FileConfiguration
      root_dir: @project_directory
      test_dir_name: @mycha_configuration.options.testDir
      default_files: Mycha.default_files
      run_files: run_files

    @call_mocha @get_mocha_args(),
                done


  # TODO: implement the watch command here
  watch: (run_options, files) ->


  # Runs mocha with the given command-line arguments.
  #
  # Parameters:
  # - mocha_args: Array of string arguments to provide to Mocha.
  call_mocha: (mocha_args, done) ->
    childProcess = child.spawn path.resolve(__dirname, '../node_modules/mocha/bin/mocha'),
                               mocha_args
    childProcess.stdout.pipe @mycha_configuration.options.stdout
    childProcess.stderr.pipe @mycha_configuration.options.stderr
    childProcess.on 'exit', done if done



module.exports = Mycha
