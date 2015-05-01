glob = require 'glob'
path = require 'path'


class TestFinder

  constructor: ({@cwd, @testFileRegex}) ->


  find: (done) ->
    unless @testFileRegex
      return done Error 'Please define a "testFileRegex" in your configuration file.'

    glob(
      "#{@cwd}/**"
      ignore: "#{@cwd}/**/node_modules/**"
      (err, files) =>
        if err then return done err
        done null, files.filter (file) => file.match @testFileRegex)


module.exports = TestFinder
