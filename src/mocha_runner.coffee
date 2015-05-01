mochaExecutablePath = require.resolve 'mocha/bin/mocha'
spawn = require 'cross-spawn'


class MochaRunner

  constructor: ({@args, @silent}) ->


  run: (done) ->
    stdio = if @silent then 'ignore' else 'inherit'
    childProcess = spawn mochaExecutablePath, @args, {stdio}
    childProcess.on 'exit', (exitCode) -> done null, exitCode


module.exports = MochaRunner
