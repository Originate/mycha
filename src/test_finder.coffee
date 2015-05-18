glob = require 'glob'
path = require 'path'


class TestFinder

  constructor: ({@cwd, @testFilePattern}) ->


  find: (done) ->
    unless @testFilePattern
      return done Error 'Please define a "testFilePattern" in your configuration file.'

    options =
      cwd: @cwd
      ignore: '**/node_modules/**'

    glob @testFilePattern, options, (err, files) =>
      if err then return done err
      done null, files.map (file) => path.join(@cwd, file)


module.exports = TestFinder
