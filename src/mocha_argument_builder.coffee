dargs = require 'dargs'
minimist = require 'minimist'
TestFinder = require './test_finder'


# Builds the argv to pass to mocha
class MochaArgumentBuilder

  # argv - arguments to pass to mocha
  # config - mycha config
  #   mochaOptions: object of options to pass to mocha
  #   testFileRegex: regular expression for finding files
  #   testHelpers: array of paths to test helpers
  # cwd - where to search for test files if none provided in argv
  constructor: ({@argv, @config, @cwd}) ->


  # Returns the arguments to pass to mocha
  #   prepending all mocha options and test helper paths from the config
  #   appending all test files unless specific files are provided in argv
  build: (done) ->
    @_getTestFiles @config.testFileRegex, (err, files) =>
      if err then return done err
      done null, dargs(@config.mochaOptions).concat @config.testHelpers, @argv, files


  _getTestFiles: (testFileRegex, done) ->
    if minimist(@argv)._.length > 0
      done null, []
    else
      new TestFinder({@cwd, testFileRegex}).find (err, files) ->
        if err then return done err
        if files.length is 0 then files = ['.']
        done null, files


module.exports = MochaArgumentBuilder
