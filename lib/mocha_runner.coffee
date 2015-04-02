MochaArgumentBuilder = require './mocha_argument_builder'
mochaExecutablePath = require.resolve 'mocha/bin/mocha'
spawn = require 'cross-spawn'


class MochaRunner

  constructor: ({argv, cwd}) ->
    @argumentBuilder = new MochaArgumentBuilder {argv, cwd}


  run: (done) ->
    @argumentBuilder.build (err, args) ->
      if err then return done err
      childProcess = spawn mochaExecutablePath, args, stdio: 'inherit'
      childProcess.on 'exit', (exitCode) -> done null, exitCode


module.exports = MochaRunner
