_ = require 'lodash'
dargs = require 'dargs'
fs = require 'fs'
minimist = require 'minimist'
path = require 'path'
TestFinder = require './test_finder'


# Builds the argv to pass to mocha
class MochaArgumentBuilder

  constructor: ({@argv, @cwd}) ->


  # Prepends the mocha options found in mycha.coffee
  # Appends all test files unless specific files are provided
  build: (done) ->
    @_loadConfig (err, config) =>
      if err then return done err
      @_getTestFiles config, (err, files) =>
        if err then return done err
        done null, @_buildDefault(config).concat(@argv).concat(files)


  _buildDefault: ({mochaOptions, testHelpers}) ->
    dargs(mochaOptions).concat testHelpers


  _getTestFiles: ({testFileRegex}, done) ->
    if minimist(@argv)._.length > 0
      done null, []
    else
      new TestFinder({@cwd, testFileRegex}).find (err, files) ->
        if err then return done err
        if files.length is 0 then files = ['.']
        done null, files


  _loadConfig: (done) ->
    configPath = path.join @cwd, 'mycha.coffee'
    fs.exists configPath, (exists) ->
      config = mochaOptions: {}, testFileRegex: null, testHelpers: []
      _.assign config, require configPath if exists
      done null, config


module.exports = MochaArgumentBuilder
